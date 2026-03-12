(*

    The Parsed AST

*)
type var = string

type datatype = 
    | Int
    | Bool

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

type unop = Neg

type expr = 
    | Int of int
    | Bool of bool
    | Ident of string
    | Binop of binop * expr * expr
    | Unop of unop * expr
    | Assign of string * expr

type arg = Arg of datatype * var

type stmt = 
    | Expr of expr
    | Return of expr option
    | Decl of datatype * var * expr option
    | If of expr * block * block option
    | Func of func

and block = stmt list

and func = {
    name: var;
    args: arg list;
    return_type: datatype;
    body: block;
}
