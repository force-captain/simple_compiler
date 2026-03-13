
type binding =
    | Var of Past.datatype
    | Fun of Past.funcsig

type var_env = (string * binding) list list

val infer : var_env -> Past.expr -> Past.typed_expr

val check : var_env -> Past.stmt -> Past.datatype option -> (Past.typed_stmt * var_env)

val check_b : var_env -> Past.block -> Past.datatype option -> Past.typed_block

val check_program : Past.block -> Past.typed_block
