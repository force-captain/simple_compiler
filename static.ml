open Past

let complain = Errors.complain

let internal_error msg = complain ("INTERNAL ERROR: " ^ msg)

let report_e e msg = 
    let loc = loc_of_expr e in
    let loc_str = string_of_loc loc in
    let e_str = string_of_expr e in 
    complain ("Error at location " ^ loc_str ^ "\n\n" ^ e_str ^ "\n\n" ^ msg)

let report_s s msg =
    let loc = loc_of_stmt s in
    let loc_str = string_of_loc loc in 
    let s_str = string_of_stmt s in 
    complain ("Error at location " ^ loc_str ^ "\n\n" ^ s_str ^ "\n\n" ^ msg)

let report_type e = report_e e "Type mismatch"

let complain_f f = complain ("Argument mismatch in " ^ f)

type binding =
    | Var of datatype
    | Fun of funcsig

type var_env = (string * binding) list list

let enter_scope env = []::env

let add x t env =
    match env with 
    | scope::rest -> ((x, t)::scope)::rest
    | [] -> failwith "Scope error!"

let rec lookup_scope x scope = 
    match scope with
    | [] -> None
    | (y,t)::rest -> if x = y then Some t else lookup_scope x rest

let rec lookup x env = 
    match env with
    | [] -> None
    | scope::rest -> 
        match lookup_scope x scope with
        | Some t -> Some t
        | None -> lookup x rest

let decl_here x env = 
    match env with 
    | [] -> false
    | scope::rest -> match lookup_scope x scope with
        | None -> false
        | Some _ -> true

let make_int_bop loc bop (e1, t1) (e2, t2) =
    match t1, t2 with
    | TInt, TInt -> (Binop(loc, bop, e1, e2), t1)
    | TInt, t    -> report_type e2
    | t,    _    -> report_type e1

let make_bool_bop loc bop (e1, t1) (e2, t2) =
    match t1, t2 with
    | TBool, TBool -> (Binop(loc, bop, e1, e2), t1)
    | TBool, t     -> report_type e2
    | t,     _     -> report_type e1

let make_bop loc bop e1 e2 = 
    match bop with
    | Add -> make_int_bop loc bop e1 e2
    | Sub -> make_int_bop loc bop e1 e2
    | Mul -> make_int_bop loc bop e1 e2
    | Div -> make_int_bop loc bop e1 e2
    | Ge -> make_bool_bop loc bop e1 e2
    | Gt -> make_bool_bop loc bop e1 e2 
    | Le -> make_bool_bop loc bop e1 e2
    | Lt -> make_bool_bop loc bop e1 e2
    | Equal -> make_bool_bop loc bop e1 e2
    | Nequal -> make_bool_bop loc bop e1 e2
    | Lor -> make_bool_bop loc bop e1 e2
    | Land -> make_bool_bop loc bop e1 e2

let make_uop loc uop (e, t) =
    match uop, t with
    | Neg, TInt  -> (Unop(loc, uop, e), t)
    | Neg, t     -> report_type e
    | Not, TBool -> (Unop(loc, uop, e), t)
    | Not, t     -> report_type e

let make_assign loc x (e, t) env = 
    match lookup x env with
    | None -> report_e e "Undeclared variable"
    | Some b -> match b with 
        | Fun(_) -> report_e e "Assigning to function!" 
        | Var(t') ->
            if t = t' then (Assign(loc, x, e), t)
            else report_type e


let rec make_args fargs is = 
    match fargs, is with
    | [], [] -> true
    | xs, [] -> false
    | [], xs -> false
    | t::xs, (_, t')::ys -> if t = t' then make_args xs ys else false

let make_ident loc x e env = 
    match lookup x env with
    | None -> report_e e "Undeclared variable!"
    | Some t -> match t with 
        | Fun(_) -> report_e e "Treating function like variable!"
        | Var(t') -> (e, t')

let rec infer env e = 
    match e with
    | Int _ -> (e, TInt)
    | Bool _ -> (e, TBool)
    | Ident (loc, x) -> make_ident loc x e env
    | Binop (loc, op, e1, e2) ->
        let i1 = infer env e1 in
        let i2 = infer env e2 in 
        make_bop loc op i1 i2
    | Unop (loc, op, e1) ->
        let i = infer env e1 in
        make_uop loc op i 
    | Assign (loc, x, e1) ->
        let i = infer env e1 in
        make_assign loc x i env
    | App (loc, f, args) -> 
        make_app loc f e env args

and infer_list env = function
    | [] -> []
    | e::es -> (infer env e)::(infer_list env es)
and make_app loc f e env args =
    match lookup f env with
    | None -> report_e e ("Undeclared function" ^ f)
    | Some t -> match t with 
        | Var(_) -> report_e e "Applying to variable!"
        | Fun((fargs, ret)) -> 
            let is = infer_list env args in 
                if make_args fargs is then (App(loc, f, args), ret)
                else report_e  e "Application parameter mismatch!"


let check_decl s t x e env = 
    match decl_here x env with
    | true  -> report_s s "Redeclaring variable"
    | false -> let env = add x (Var t) env in 
                (match e with
                | None -> (s, env)
                | Some e -> 
                    let (_, t') = infer env e in
                    if t' = t then (s, env)
                    else report_s s "Type mismatch!")

let rec check env s rtype = 
    match s with 
    | Expr (loc, e) -> let _ = infer env e in (s, env)
    | Return (loc, e) -> 
        (match e with 
        | None -> if rtype = Some TUnit then (s, env)
                  else report_s s "Return type mismatch"
        | Some e -> let (_, t) = infer env e in 
                    if Some t = rtype then (s, env)
                    else report_s s "Return type mismatch")
    | Decl (loc, t, x, e) -> check_decl s t x e env
    | If (loc, cond, thenb, elseb) -> check_if s cond thenb elseb env rtype
    | Func (loc, f) -> check_fun f s env
    

and check_b env block rtype = 
    List.fold_left (fun e s ->
        let (_, e') = check e s rtype in e'
    ) env block


and check_if s cond thenb elseb env rtype = 
    let (_, t_cond) = infer env cond in 
    if t_cond <> TBool then report_e cond ("Type error, expected bool!");
    let env_then = enter_scope env in 
    let _ = check_b env_then thenb rtype in
    match elseb with 
        | None -> (s, env)
        | Some b -> let env_else = enter_scope env in
                    let _ = check_b env_else b rtype in 
                    (s, env)

and check_fun f s env = 
    let args = List.map (fun (Arg (t, _)) -> t) f.args in
    let signature = Fun(args, f.return_type) in 
    let env = add f.name signature env in 
    let env' = enter_scope env in 
    let env' = List.fold_left (fun e (Arg (t, x)) -> add x (Var(t)) e) env' f.args in 
    let _ = check_b env' f.body (Some f.return_type) in (s, env)

