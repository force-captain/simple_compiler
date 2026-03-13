
let translate_uop = function 
    | Past.Neg -> Ast.Neg 
    | Past.Not -> Ast.Not 

let translate_bop = function 
    | Past.Ge     -> Ast.Ge 
    | Past.Le     -> Ast.Le 
    | Past.Gt     -> Ast.Gt 
    | Past.Lt     -> Ast.Lt 
    | Past.Lor    -> Ast.Or 
    | Past.Add    -> Ast.Add
    | Past.Sub    -> Ast.Sub 
    | Past.Mul    -> Ast.Mul
    | Past.Div    -> Ast.Div
    | Past.Land   -> Ast.And
    | Past.Equal  -> Ast.Equal 
    | Past.Nequal -> Ast.Nequal

let translate_type = function
    | Past.IntType  -> Ast.TInt
    | Past.BoolType -> Ast.TBool
    | Past.UnitType -> Ast.TUnit

let rec translate_expr = function 
    | Past.TInt    (_, n, t)            -> Ast.Int      (n, translate_type t) 
    | Past.TBool   (_, b, t)            -> Ast.Bool     (b, translate_type t)
    | Past.TIdent  (_, x, t)            -> Ast.Ident    (x, translate_type t)
    | Past.TAssign (_, x, e, t)         -> Ast.Assign   (x, translate_expr e, translate_type t)
    | Past.TApp    (_, f, xs, t)        -> Ast.App      (f, translate_exps xs, translate_type t)
    | Past.TUnop   (_, op, e, t)        -> Ast.UnaryOp  
                                            (translate_uop op, translate_expr e, translate_type t) 
    | Past.TBinop  (_, op, e1, e2, t)   -> Ast.BinaryOp (
                                                            translate_bop op, 
                                                            translate_expr e1, 
                                                            translate_expr e2, 
                                                            translate_type t)
and translate_exps = function 
    | [] -> []
    | e::es -> (translate_expr e)::(translate_exps es)

let translate_arg = function 
    | Past.Arg(t, x) -> Ast.Arg(x, translate_type t)

let rec translate_args = function
    | [] -> []
    | a::rest -> (translate_arg a)::(translate_args rest)


let rec translate_stmt = function 
    | Past.TExpr    (_, e)                      -> Ast.Expr (translate_expr e)
    | Past.TReturn  (_, None)                   -> Ast.Return None
    | Past.TReturn  (_, Some e)                 -> Ast.Return (Some (translate_expr e))
    | Past.TDecl    (_, t, x, None)             -> Ast.Decl(translate_type t, x, None)
    | Past.TDecl    (_, t, x, Some e)           -> Ast.Decl(translate_type t, x, (Some (translate_expr e)))
    | Past.TIf      (_, con, thenb, None)       -> Ast.If(translate_expr con, translate_block thenb, None)
    | Past.TIf      (_, con, thenb, Some elseb) -> Ast.If(
                                                        translate_expr con, 
                                                        translate_block thenb, 
                                                        (Some (translate_block elseb)))
    | Past.TFunc    (_, f)                      -> Ast.Func({
                                                        name = f.name;
                                                        args = translate_args f.args;
                                                        return_type = translate_type f.return_type;
                                                        body = translate_block f.body;
                                                    })
and translate_block = function 
    | [] -> []
    | s::ss -> (translate_stmt s)::(translate_block ss)
