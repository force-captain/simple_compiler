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

let type_mismatch e t =
    complain "Type mismatch!"

let complain_f f = complain ("Argument mismatch in " ^ f)

type binding =
    | Var of datatype
    | Fun of funcsig

type var_env = (string * binding) list list

let init_env = [[]]

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

let make_int_bop loc bop e1 e2 =
    let t1 = get_type e1 in let t2 = get_type e2 in
    match t1, t2 with
    | IntType, IntType -> TBinop(loc, bop, e1, e2, t1)
    | IntType, t    -> type_mismatch e2 t
    | t,       _    -> type_mismatch e1 t

let make_bool_bop loc bop e1 e2 =
    let t1 = get_type e1 in let t2 = get_type e2 in
    match t1, t2 with
    | BoolType, BoolType -> TBinop(loc, bop, e1, e2, t1)
    | BoolType, t     -> type_mismatch e2 t
    | t,        _     -> type_mismatch e1 t

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

let make_uop loc uop e =
    let t = get_type e in 
    match uop, t with
    | Neg, IntType  -> TUnop(loc, uop, e, t)
    | Neg, t'     -> type_mismatch e t'
    | Not, BoolType -> TUnop(loc, uop, e, t)
    | Not, t'     -> type_mismatch e t'

let make_assign loc x e env = 
    let t = get_type e in
    match lookup x env with
    | None -> complain "Undeclared variable!"
    | Some b -> match b with 
        | Fun(_) -> complain "Assign to function!"
        | Var(t') ->
            if t = t' then TAssign(loc, x, e, t)
            else type_mismatch e t'


let rec make_args fargs is = 
    match fargs, is with
    | [], [] -> true
    | xs, [] -> false
    | [], xs -> false
    | t::xs, e::ys -> let t' = get_type e in if t = t' then make_args xs ys else false

let rec check_unique = function 
    | [] -> ()
    | Arg(_,x)::xs ->  if List.exists (fun (Arg(_,y)) -> x = y) xs then 
                        complain "Non-unique argument!"
                    else check_unique xs

let make_ident loc x e env = 
    match lookup x env with
    | None -> report_e e "Undeclared variable!"
    | Some t -> match t with 
        | Fun(_) -> report_e e "Treating function like variable!"
        | Var(t') -> TIdent (loc, x, t')

let rec infer env e = 
    match e with
    | Int  (l, n) -> TInt (l, n, IntType)
    | Bool (l, b) -> TBool (l, b, BoolType)
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
                if make_args fargs is then TApp(loc, f, is, ret)
                else report_e  e "Application parameter mismatch!"


let check_decl loc t x e env = 
    match e with 
    | None -> let env = add x (Var t) env in (TDecl(loc, t, x, None), env)
    | Some e -> 
        let e' = infer env e in
        if get_type e' = t then 
            let env = add x (Var t) env in (TDecl(loc, t, x, Some e'), env) 
        else type_mismatch e' t

let rec check env s rtype = 
    match s with 
    | Expr (loc, e) -> let e' = infer env e in (TExpr (loc, e'), env)
    | Return (loc, e) -> 
        (match e with 
        | None -> if rtype = Some UnitType then (TReturn (loc, None), env)
                  else report_s s "Return type mismatch"
        | Some e -> let e' = infer env e in 
                    if Some (get_type e') = rtype then (TReturn(loc, Some e'), env)
                    else report_s s "Return type mismatch")
    | Decl (loc, t, x, e) -> check_decl loc t x e env
    | If (loc, cond, thenb, elseb) -> check_if loc cond thenb elseb env rtype
    | Func (loc, f) -> check_fun loc f env
and check_b env block rtype = 
    match block with 
    | [] -> [] 
    | s::rest -> match check env s rtype with 
        | (s', env') -> s'::(check_b env' rest rtype)

and check_if loc cond thenb elseb env rtype = 
    let cond' = infer env cond in 
    if get_type cond' <> BoolType then report_e cond ("Type error, expected bool!");
    let env_then = enter_scope env in 
    let thenb' = check_b env_then thenb rtype in
    match elseb with 
        | None -> (TIf(loc, cond', thenb', None), env)
        | Some b -> let env_else = enter_scope env in
                    let elseb' = check_b env_else b rtype in 
                    (TIf(loc, cond', thenb', (Some elseb')), env)

and check_fun loc f env = 
    check_unique f.args;
    let args = List.map (fun (Arg (t, _)) -> t) f.args in
    let signature = Fun(args, f.return_type) in 
    let env = add f.name signature env in 
    let env' = enter_scope env in 
    let env' = List.fold_left (fun e (Arg (t, x)) -> add x (Var(t)) e) env' f.args in 
    let body' = check_b env' f.body (Some f.return_type) in 
    (TFunc(loc, {
        name = f.name;
        args = f.args;
        return_type = f.return_type;
        body = body';
    }), env)

let check_program p = check_b init_env p None
