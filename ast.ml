
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

let pp_uop = function
    | Neg -> "-" 
    | Not -> "!"

let pp_bop = function
    | Add -> "+"
    | Mul -> "*"
    | Div -> "/"
    | Sub -> "-" 
    | Gt  -> ">"
    | Lt  -> "<"
    | Ge  -> ">=" 
    | Le  -> "<="
    | Or  -> "||"
    | And -> "&&" 
    | Equal -> "=="
    | Nequal -> "!=" 

let pp_type = function 
    | TInt -> "int"
    | TBool -> "bool"
    | TUnit -> "void"

let pp_arg = function
    | Arg (n, t) -> pp_type t ^ " " ^ n

open Format

let tabstop = 4

let string_of_bop = pp_bop 
let string_of_uop = pp_uop

let fstring ppf s = fprintf ppf "%s" s

let pp_unary  ppf t = fstring ppf (pp_uop t)
let pp_binary ppf t = fstring ppf (pp_bop t)
let pp_type   ppf t = fstring ppf (pp_type t)

let pp_arg    ppf t = fstring ppf (pp_arg t)

let rec pp_arg_list ppf = function 
    | [] -> ()
    | [a] -> pp_arg ppf a 
    | a::rest -> fprintf ppf "%a, %a" pp_arg a pp_arg_list rest

let rec pp_expr ppf = function 
    | Int (n, t) -> fprintf ppf "%s:%a" (string_of_int n) pp_type t
    | Bool (b, t) -> fprintf ppf "%s:%a" (string_of_bool b) pp_type t
    | Ident (v, t) -> fprintf ppf "%s:%a" v pp_type t
    | BinaryOp (op, e1, e2, t) -> 
        fprintf ppf "(%a %a %a)" pp_expr e1 pp_binary op pp_expr e2
    | UnaryOp (op, e, t) ->
        fprintf ppf "%a(%a)" pp_unary op pp_expr e
    | Assign (v, e, t) -> fprintf ppf "%s:%a = %a" v pp_type t pp_expr e
    | App (f, args, t) -> 
        fprintf ppf "%s(%a):%a" f pp_expr_list args pp_type t
and pp_expr_list ppf = function 
    | [] -> ()
    | [e] -> pp_expr ppf e 
    | e::rest -> fprintf ppf "%a, %a" pp_expr e pp_expr_list rest

let rec pp_stmt scope ppf s =
    let i = String.make (tabstop * scope) ' ' in 
    match s with
    | Expr e -> fprintf ppf "%s%a;" i pp_expr e
    | Return None -> fprintf ppf "%sreturn;" i
    | Return Some e -> fprintf ppf "%sreturn %a;" i pp_expr e
    | Decl (t, x, None) -> fprintf ppf "%s%a %s;" i pp_type t x
    | Decl (t, x, Some e) -> fprintf ppf "%s%a %s = %a;" i pp_type t x pp_expr e
    | If (cond, thenb, None) -> fprintf ppf "%sif (%a) {\n%a\n%s}" i pp_expr cond (pp_block (scope+1)) thenb i
    | If (cond, thenb, Some elseb) -> 
        fprintf ppf "%sif (%a) {\n%a\n%s} else {\n%a\n%s}" 
            i pp_expr cond (pp_block (scope+1)) thenb i (pp_block (scope+1)) elseb i
    | Func f ->
        fprintf ppf "%s%a %s(%a) {\n%a\n%s}" 
            i pp_type f.return_type f.name pp_arg_list f.args (pp_block (scope+1)) f.body i
and pp_block scope ppf = function 
    | [] -> () 
    | [s] -> fprintf ppf "%a" (pp_stmt scope) s
    | s::rest -> fprintf ppf "%a\n%a" (pp_stmt scope) s (pp_block scope) rest

let print_stmt s = 
    let _ = pp_stmt 0 std_formatter s
    in print_flush()

let print_block b = 
    let _ = pp_block 0 std_formatter b
    in print_flush()
