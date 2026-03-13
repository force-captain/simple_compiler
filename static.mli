
type binding =
    | Var of Past.datatype
    | Fun of Past.funcsig

type var_env = (string * binding) list list

val infer : var_env -> Past.expr -> (Past.expr * Past.datatype)

val check : var_env -> Past.stmt -> Past.datatype option -> (Past.stmt * var_env)

val check_b : var_env -> Past.block -> Past.datatype option -> var_env
