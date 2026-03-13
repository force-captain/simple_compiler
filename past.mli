type var = string

type loc = Lexing.position

type datatype = 
    | TInt
    | TBool
    | TUnit

type funcsig = datatype list * datatype

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

type expr = 
    | Int of loc * int
    | Bool of loc *bool
    | Ident of loc * string
    | Binop of loc * binop * expr * expr
    | Unop of loc * unop * expr
    | Assign of loc * string * expr
    | App of loc * var * expr list

type arg = Arg of datatype * var

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

val loc_of_expr : expr -> loc
val loc_of_stmt : stmt -> loc

val string_of_loc : loc -> string
val string_of_uop : unop -> string
val string_of_bop : binop -> string
val string_of_type : datatype -> string
val string_of_expr : expr -> string
val string_of_stmt : stmt -> string
val string_of_block : block -> string
