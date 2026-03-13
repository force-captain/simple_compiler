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

val loc_of_expr : expr -> loc
val loc_of_stmt : stmt -> loc

val string_of_loc : loc -> string
val string_of_uop : unop -> string
val string_of_bop : binop -> string
val string_of_type : datatype -> string
val string_of_expr : expr -> string
val string_of_stmt : stmt -> string
val string_of_block : block -> string

val get_type : typed_expr -> datatype
