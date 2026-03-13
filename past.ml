type var = string

type loc = Lexing.position

type datatype = 
    | IntType
    | BoolType
    | UnitType

type funcsig = datatype list * datatype

type arg = Arg of datatype * var

type binop = 
    | Add 
    | Mul 
    | Div 
    | Sub 
    | Gt 
    | Lt 
    | Ge
    | Le
    | Lor
    | Land
    | Equal 
    | Nequal

type unop = 
    | Neg 
    | Not

type typed_expr =
    | TInt of loc * int * datatype 
    | TBool of loc * bool * datatype 
    | TIdent of loc * var * datatype 
    | TBinop of loc * binop * typed_expr * typed_expr * datatype
    | TUnop of loc * unop * typed_expr * datatype 
    | TAssign of loc * var * typed_expr * datatype
    | TApp of loc * var * typed_expr list * datatype

type typed_stmt =
    | TExpr of loc * typed_expr 
    | TReturn of loc * typed_expr option
    | TDecl of loc * datatype * var * typed_expr option 
    | TIf of loc * typed_expr * typed_block * typed_block option 
    | TFunc of loc * typed_func

and typed_block = typed_stmt list 

and typed_func = {
    name: var;
    args: arg list;
    return_type: datatype;
    body: typed_block;
}

type expr = 
    | Int of loc * int
    | Bool of loc * bool
    | Ident of loc * var
    | Binop of loc * binop * expr * expr
    | Unop of loc * unop * expr
    | Assign of loc * var * expr
    | App of loc * var * expr list


type stmt = 
    | Expr of loc * expr
    | Return of loc * expr option
    | Decl of loc * datatype * var * expr option
    | If of loc * expr * block * block option
    | Func of loc * func

and block = stmt list

and func = {
    name: var;
    args: arg list;
    return_type: datatype;
    body: block;
}

let get_type = function 
    | TInt      (_, _, t) -> t
    | TBool     (_, _, t) -> t
    | TIdent    (_, _, t) -> t
    | TBinop    (_, _, _, _, t) -> t
    | TUnop     (_, _, _, t) -> t
    | TAssign   (_, _, _, t) -> t
    | TApp      (_, _, _, t) -> t

let loc_of_expr = function
    | Int(loc, _)           -> loc
    | Bool(loc, _)          -> loc
    | Ident(loc, _)         -> loc
    | Binop(loc, _, _, _)   -> loc
    | Unop(loc, _, _)       -> loc
    | Assign(loc, _, _)     -> loc
    | App(loc, _, _)        -> loc

let loc_of_stmt = function
    | Expr(loc, _)          -> loc
    | Return(loc, _)        -> loc
    | Decl(loc, _, _, _)    -> loc
    | If(loc, _, _, _)      -> loc
    | Func(loc, _)          -> loc


let string_of_loc loc = 
    "line " ^ (string_of_int (loc.Lexing.pos_lnum)) ^ ", " ^ 
    "position " ^ (string_of_int ((loc.Lexing.pos_cnum - loc.Lexing.pos_bol) + 1))

let mk_con con l =
    let rec aux carry = function 
    | [] -> carry ^ ")"
    | [s] -> carry ^ s ^ ")"
    | s::rest -> aux (carry ^ s ^ ", ") rest
    in aux (con ^ "(") l

let string_of_type = function
    | IntType              -> "TInt" 
    | BoolType             -> "TBool" 
    | UnitType             -> "TUnit"

let string_of_uop = function 
    | Neg -> "Neg"
    | Not -> "Not"

let string_of_bop = function
    | Add -> "Add"
    | Mul -> "Mul"
    | Div -> "Div"
    | Sub -> "Sub"
    | Ge -> "Ge"
    | Gt -> "Gt"
    | Le -> "Le"
    | Lt -> "Lt"
    | Equal -> "Equal"
    | Nequal -> "Nequal"
    | Lor -> "Lor"
    | Land -> "Land"

let rec string_of_expr = function 
    | Int(_, n) -> mk_con "Integer" [string_of_int n]
    | Bool(_, b) -> mk_con "Boolean" [string_of_bool b]
    | Unop(_, op, e1) -> mk_con "UnaryOp" [string_of_uop op; string_of_expr e1]
    | Binop(_, op, e1, e2) -> mk_con "BinaryOp" [string_of_bop op; string_of_expr e1; string_of_expr e2]
    | Ident(_, x) -> mk_con "Ident" [x]
    | Assign(_, x, e) -> mk_con "Assign" [x; string_of_expr e]
    | App(_, f, args) -> mk_con "App" (f::(List.map string_of_expr args))

let rec string_of_stmt = function
    | Expr(_, e) -> mk_con "Expr" [string_of_expr e]
    | Return(_, None) -> mk_con "Return" []
    | Return(_, Some e) -> mk_con "Return" [string_of_expr e]
    | Decl(_, t, x, None) -> mk_con "Decl" [string_of_type t; x]
    | Decl(_, t, x, Some e) -> mk_con "Decl" [string_of_type t; x; string_of_expr e]
    | If(_, c, thenb, None) -> mk_con "If" [string_of_expr c; string_of_block thenb]
    | If(_, c, thenb, Some elseb) -> mk_con "If" [string_of_expr c; string_of_block thenb; string_of_block elseb]
    | Func(_, f) -> 
        let args_str = mk_con "Args" (List.map (fun (Arg(t,x)) -> x ^ ":" ^ string_of_type t) f.args) in
        mk_con "Fun" [f.name; string_of_type f.return_type; args_str; string_of_block f.body]
and string_of_block b = mk_con "Block" (List.map string_of_stmt b)
