type var = string

type datatype = 
    | TInt 
    | TBool 
    | TUnit

type bop =
    | Add
    | Sub
    | Mul
    | Div
    | Gt
    | Lt
    | Ge
    | Le
    | And
    | Or
    | Equal
    | Nequal

type uop = Neg | Not


type expr = 
    | Int of int * datatype
    | Bool of bool * datatype
    | Ident of var * datatype
    | BinaryOp of bop * expr * expr * datatype
    | UnaryOp of uop * expr * datatype
    | Assign of var * expr * datatype
    | App of var * (expr list) * datatype

type arg = Arg of var * datatype

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


val string_of_bop : bop -> string 
val string_of_uop : uop -> string 

val print_stmt : stmt -> unit 
val print_block : block -> unit
