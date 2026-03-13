type token =
  | INT of (
# 7 "parser.mly"
        int
# 6 "parser.ml"
)
  | IDENT of (
# 8 "parser.mly"
        string
# 11 "parser.ml"
)
  | BOOL of (
# 9 "parser.mly"
        bool
# 16 "parser.ml"
)
  | INT_KWORD
  | BOOL_KWORD
  | UNIT_KWORD
  | ASSIGN
  | SEMICOLON
  | COMMA
  | RETURN
  | IF
  | ELSE
  | LOR
  | LAND
  | LNOT
  | EQUAL
  | NEQUAL
  | LT
  | LE
  | GT
  | GE
  | ADD
  | SUB
  | MUL
  | DIV
  | LPAREN
  | RPAREN
  | LBRACE
  | RBRACE
  | PRINT
  | EOF

open Parsing
let _ = parse_error;;
# 2 "parser.mly"

let get_loc = Parsing.symbol_start_pos

# 53 "parser.ml"
let yytransl_const = [|
  260 (* INT_KWORD *);
  261 (* BOOL_KWORD *);
  262 (* UNIT_KWORD *);
  263 (* ASSIGN *);
  264 (* SEMICOLON *);
  265 (* COMMA *);
  266 (* RETURN *);
  267 (* IF *);
  268 (* ELSE *);
  269 (* LOR *);
  270 (* LAND *);
  271 (* LNOT *);
  272 (* EQUAL *);
  273 (* NEQUAL *);
  274 (* LT *);
  275 (* LE *);
  276 (* GT *);
  277 (* GE *);
  278 (* ADD *);
  279 (* SUB *);
  280 (* MUL *);
  281 (* DIV *);
  282 (* LPAREN *);
  283 (* RPAREN *);
  284 (* LBRACE *);
  285 (* RBRACE *);
  286 (* PRINT *);
    0 (* EOF *);
    0|]

let yytransl_block = [|
  257 (* INT *);
  258 (* IDENT *);
  259 (* BOOL *);
    0|]

let yylhs = "\255\255\
\001\000\014\000\014\000\009\000\009\000\003\000\003\000\003\000\
\003\000\003\000\006\000\006\000\002\000\002\000\002\000\002\000\
\002\000\002\000\002\000\002\000\002\000\002\000\002\000\002\000\
\002\000\002\000\002\000\002\000\007\000\007\000\005\000\005\000\
\004\000\004\000\004\000\004\000\004\000\015\000\015\000\011\000\
\011\000\010\000\010\000\012\000\012\000\013\000\013\000\008\000\
\000\000"

let yylen = "\002\000\
\002\000\001\000\001\000\001\000\001\000\001\000\001\000\001\000\
\004\000\003\000\001\000\002\000\001\000\002\000\002\000\003\000\
\003\000\003\000\003\000\003\000\003\000\003\000\003\000\003\000\
\003\000\003\000\003\000\003\000\002\000\000\000\007\000\011\000\
\002\000\002\000\002\000\001\000\001\000\002\000\004\000\000\000\
\003\000\000\000\004\000\000\000\002\000\000\000\003\000\008\000\
\002\000"

let yydefred = "\000\000\
\000\000\000\000\006\000\000\000\007\000\002\000\003\000\005\000\
\000\000\000\000\000\000\000\000\000\000\049\000\000\000\013\000\
\000\000\036\000\000\000\000\000\037\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\014\000\000\000\033\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\029\000\035\000\001\000\000\000\
\000\000\034\000\000\000\000\000\000\000\000\000\010\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\018\000\019\000\000\000\000\000\000\000\045\000\009\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\047\000\000\000\000\000\000\000\041\000\000\000\000\000\000\000\
\000\000\048\000\000\000\000\000\043\000\000\000\032\000"

let yydgoto = "\002\000\
\014\000\015\000\016\000\017\000\018\000\019\000\020\000\021\000\
\022\000\085\000\074\000\053\000\071\000\023\000\024\000"

let yysindex = "\020\000\
\039\255\000\000\000\000\253\254\000\000\000\000\000\000\000\000\
\045\255\013\255\045\255\045\255\045\255\000\000\220\255\000\000\
\039\255\000\000\047\255\053\000\000\000\065\255\067\255\066\255\
\045\255\045\255\062\000\045\255\249\254\000\000\032\000\000\000\
\045\255\045\255\045\255\045\255\045\255\045\255\045\255\045\255\
\045\255\045\255\045\255\045\255\000\000\000\000\000\000\050\255\
\072\255\000\000\062\000\019\000\063\255\047\000\000\000\249\254\
\249\254\201\255\201\255\230\255\230\255\230\255\230\255\001\255\
\001\255\000\000\000\000\054\255\045\255\045\255\000\000\000\000\
\068\255\083\255\092\255\062\000\019\000\039\255\071\255\086\255\
\000\000\097\255\039\255\054\255\000\000\103\255\099\255\110\255\
\113\255\000\000\086\255\039\255\000\000\102\255\000\000"

let yyrindex = "\000\000\
\138\000\000\000\000\000\064\255\000\000\000\000\000\000\000\000\
\134\255\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\002\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\119\255\145\255\000\000\043\255\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\148\255\000\000\205\255\130\255\000\000\000\000\000\000\193\255\
\208\255\116\255\131\255\146\255\161\255\176\255\191\255\084\255\
\100\255\000\000\000\000\135\255\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\153\255\130\255\139\255\000\000\136\255\
\000\000\000\000\139\255\000\000\000\000\001\000\000\000\000\000\
\000\000\000\000\136\255\139\255\000\000\000\000\000\000"

let yygindex = "\000\000\
\000\000\250\255\000\000\000\000\000\000\000\000\239\255\000\000\
\000\000\080\000\000\000\000\000\095\000\196\255\000\000"

let yytablesize = 343
let yytable = "\045\000\
\031\000\030\000\027\000\025\000\029\000\030\000\031\000\075\000\
\035\000\036\000\037\000\038\000\039\000\040\000\041\000\042\000\
\043\000\044\000\051\000\052\000\001\000\054\000\026\000\088\000\
\043\000\044\000\056\000\057\000\058\000\059\000\060\000\061\000\
\062\000\063\000\064\000\065\000\066\000\067\000\028\000\003\000\
\004\000\005\000\006\000\007\000\008\000\003\000\004\000\005\000\
\009\000\010\000\015\000\015\000\047\000\011\000\046\000\015\000\
\015\000\006\000\007\000\011\000\082\000\012\000\076\000\077\000\
\013\000\087\000\048\000\012\000\049\000\015\000\013\000\008\000\
\008\000\050\000\094\000\068\000\008\000\008\000\069\000\008\000\
\008\000\008\000\008\000\008\000\008\000\008\000\008\000\008\000\
\008\000\072\000\008\000\016\000\016\000\080\000\084\000\078\000\
\016\000\016\000\083\000\016\000\016\000\016\000\016\000\016\000\
\016\000\016\000\016\000\017\000\017\000\079\000\016\000\091\000\
\017\000\017\000\089\000\017\000\017\000\017\000\017\000\017\000\
\017\000\017\000\017\000\026\000\026\000\086\000\017\000\090\000\
\026\000\026\000\095\000\026\000\026\000\026\000\026\000\026\000\
\026\000\030\000\027\000\027\000\092\000\011\000\026\000\027\000\
\027\000\044\000\027\000\027\000\027\000\027\000\027\000\027\000\
\012\000\020\000\020\000\038\000\046\000\027\000\020\000\020\000\
\039\000\040\000\042\000\020\000\020\000\020\000\020\000\030\000\
\022\000\022\000\093\000\081\000\020\000\022\000\022\000\000\000\
\000\000\000\000\022\000\022\000\022\000\022\000\000\000\021\000\
\021\000\000\000\000\000\022\000\021\000\021\000\000\000\000\000\
\000\000\021\000\021\000\021\000\021\000\000\000\023\000\023\000\
\024\000\024\000\021\000\023\000\023\000\024\000\024\000\000\000\
\023\000\023\000\023\000\023\000\028\000\028\000\000\000\025\000\
\025\000\023\000\000\000\024\000\025\000\025\000\041\000\042\000\
\043\000\044\000\000\000\032\000\000\000\000\000\000\000\028\000\
\033\000\034\000\025\000\035\000\036\000\037\000\038\000\039\000\
\040\000\041\000\042\000\043\000\044\000\035\000\036\000\000\000\
\000\000\000\000\000\000\041\000\042\000\043\000\044\000\000\000\
\000\000\031\000\031\000\031\000\031\000\031\000\031\000\000\000\
\000\000\000\000\031\000\031\000\000\000\000\000\000\000\031\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\031\000\
\000\000\000\000\031\000\070\000\000\000\031\000\030\000\033\000\
\034\000\000\000\035\000\036\000\037\000\038\000\039\000\040\000\
\041\000\042\000\043\000\044\000\033\000\034\000\000\000\035\000\
\036\000\037\000\038\000\039\000\040\000\041\000\042\000\043\000\
\044\000\000\000\055\000\033\000\034\000\000\000\035\000\036\000\
\037\000\038\000\039\000\040\000\041\000\042\000\043\000\044\000\
\000\000\073\000\033\000\034\000\000\000\035\000\036\000\037\000\
\038\000\039\000\040\000\041\000\042\000\043\000\044\000"

let yycheck = "\017\000\
\000\000\000\000\009\000\007\001\011\000\012\000\013\000\068\000\
\016\001\017\001\018\001\019\001\020\001\021\001\022\001\023\001\
\024\001\025\001\025\000\026\000\001\000\028\000\026\001\084\000\
\024\001\025\001\033\000\034\000\035\000\036\000\037\000\038\000\
\039\000\040\000\041\000\042\000\043\000\044\000\026\001\001\001\
\002\001\003\001\004\001\005\001\006\001\001\001\002\001\003\001\
\010\001\011\001\008\001\009\001\000\000\015\001\008\001\013\001\
\014\001\004\001\005\001\015\001\078\000\023\001\069\000\070\000\
\026\001\083\000\002\001\023\001\002\001\027\001\026\001\008\001\
\009\001\008\001\092\000\026\001\013\001\014\001\007\001\016\001\
\017\001\018\001\019\001\020\001\021\001\022\001\023\001\024\001\
\025\001\027\001\027\001\008\001\009\001\002\001\009\001\028\001\
\013\001\014\001\028\001\016\001\017\001\018\001\019\001\020\001\
\021\001\022\001\023\001\008\001\009\001\027\001\027\001\002\001\
\013\001\014\001\012\001\016\001\017\001\018\001\019\001\020\001\
\021\001\022\001\023\001\008\001\009\001\029\001\027\001\029\001\
\013\001\014\001\029\001\016\001\017\001\018\001\019\001\020\001\
\021\001\000\000\008\001\009\001\028\001\008\001\027\001\013\001\
\014\001\027\001\016\001\017\001\018\001\019\001\020\001\021\001\
\008\001\008\001\009\001\008\001\027\001\027\001\013\001\014\001\
\008\001\027\001\027\001\018\001\019\001\020\001\021\001\029\001\
\008\001\009\001\091\000\077\000\027\001\013\001\014\001\255\255\
\255\255\255\255\018\001\019\001\020\001\021\001\255\255\008\001\
\009\001\255\255\255\255\027\001\013\001\014\001\255\255\255\255\
\255\255\018\001\019\001\020\001\021\001\255\255\008\001\009\001\
\008\001\009\001\027\001\013\001\014\001\013\001\014\001\255\255\
\018\001\019\001\020\001\021\001\008\001\009\001\255\255\008\001\
\009\001\027\001\255\255\027\001\013\001\014\001\022\001\023\001\
\024\001\025\001\255\255\008\001\255\255\255\255\255\255\027\001\
\013\001\014\001\027\001\016\001\017\001\018\001\019\001\020\001\
\021\001\022\001\023\001\024\001\025\001\016\001\017\001\255\255\
\255\255\255\255\255\255\022\001\023\001\024\001\025\001\255\255\
\255\255\001\001\002\001\003\001\004\001\005\001\006\001\255\255\
\255\255\255\255\010\001\011\001\255\255\255\255\255\255\015\001\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\023\001\
\255\255\255\255\026\001\009\001\255\255\029\001\029\001\013\001\
\014\001\255\255\016\001\017\001\018\001\019\001\020\001\021\001\
\022\001\023\001\024\001\025\001\013\001\014\001\255\255\016\001\
\017\001\018\001\019\001\020\001\021\001\022\001\023\001\024\001\
\025\001\255\255\027\001\013\001\014\001\255\255\016\001\017\001\
\018\001\019\001\020\001\021\001\022\001\023\001\024\001\025\001\
\255\255\027\001\013\001\014\001\255\255\016\001\017\001\018\001\
\019\001\020\001\021\001\022\001\023\001\024\001\025\001"

let yynames_const = "\
  INT_KWORD\000\
  BOOL_KWORD\000\
  UNIT_KWORD\000\
  ASSIGN\000\
  SEMICOLON\000\
  COMMA\000\
  RETURN\000\
  IF\000\
  ELSE\000\
  LOR\000\
  LAND\000\
  LNOT\000\
  EQUAL\000\
  NEQUAL\000\
  LT\000\
  LE\000\
  GT\000\
  GE\000\
  ADD\000\
  SUB\000\
  MUL\000\
  DIV\000\
  LPAREN\000\
  RPAREN\000\
  LBRACE\000\
  RBRACE\000\
  PRINT\000\
  EOF\000\
  "

let yynames_block = "\
  INT\000\
  IDENT\000\
  BOOL\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : Past.block) in
    Obj.repr(
# 59 "parser.mly"
                         ( _1 )
# 294 "parser.ml"
               : Past.block))
; (fun __caml_parser_env ->
    Obj.repr(
# 63 "parser.mly"
                            ( Past.IntType )
# 300 "parser.ml"
               : Past.datatype))
; (fun __caml_parser_env ->
    Obj.repr(
# 64 "parser.mly"
                            ( Past.BoolType )
# 306 "parser.ml"
               : Past.datatype))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : Past.datatype) in
    Obj.repr(
# 68 "parser.mly"
                            ( _1 )
# 313 "parser.ml"
               : Past.datatype))
; (fun __caml_parser_env ->
    Obj.repr(
# 69 "parser.mly"
                            ( Past.UnitType )
# 319 "parser.ml"
               : Past.datatype))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 73 "parser.mly"
                                ( Past.Int (get_loc(), _1) )
# 326 "parser.ml"
               : Past.expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : bool) in
    Obj.repr(
# 74 "parser.mly"
                                ( Past.Bool (get_loc(), _1) )
# 333 "parser.ml"
               : Past.expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 75 "parser.mly"
                                ( Past.Ident (get_loc(), _1) )
# 340 "parser.ml"
               : Past.expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : Past.expr list) in
    Obj.repr(
# 76 "parser.mly"
                                       ( Past.App(get_loc(), _1, _3) )
# 348 "parser.ml"
               : Past.expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : Past.expr) in
    Obj.repr(
# 77 "parser.mly"
                                ( _2 )
# 355 "parser.ml"
               : Past.expr))
; (fun __caml_parser_env ->
    Obj.repr(
# 81 "parser.mly"
                                ( Past.Return (get_loc(), None) )
# 361 "parser.ml"
               : Past.stmt))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : Past.expr) in
    Obj.repr(
# 82 "parser.mly"
                                ( Past.Return (get_loc(), (Some _2)) )
# 368 "parser.ml"
               : Past.stmt))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : Past.expr) in
    Obj.repr(
# 86 "parser.mly"
                                            ( _1 )
# 375 "parser.ml"
               : Past.expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : Past.expr) in
    Obj.repr(
# 87 "parser.mly"
                                            ( Past.Unop(get_loc(), Neg,         _2) )
# 382 "parser.ml"
               : Past.expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : Past.expr) in
    Obj.repr(
# 88 "parser.mly"
                                            ( Past.Unop(get_loc(), Not,         _2) )
# 389 "parser.ml"
               : Past.expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Past.expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Past.expr) in
    Obj.repr(
# 89 "parser.mly"
                                            ( Past.Binop(get_loc(), Add,    _1, _3) )
# 397 "parser.ml"
               : Past.expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Past.expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Past.expr) in
    Obj.repr(
# 90 "parser.mly"
                                            ( Past.Binop(get_loc(), Sub,    _1, _3) )
# 405 "parser.ml"
               : Past.expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Past.expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Past.expr) in
    Obj.repr(
# 91 "parser.mly"
                                            ( Past.Binop(get_loc(), Mul,    _1, _3) )
# 413 "parser.ml"
               : Past.expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Past.expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Past.expr) in
    Obj.repr(
# 92 "parser.mly"
                                            ( Past.Binop(get_loc(), Div,    _1, _3) )
# 421 "parser.ml"
               : Past.expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Past.expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Past.expr) in
    Obj.repr(
# 93 "parser.mly"
                                            ( Past.Binop(get_loc(), Lt,     _1, _3) )
# 429 "parser.ml"
               : Past.expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Past.expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Past.expr) in
    Obj.repr(
# 94 "parser.mly"
                                            ( Past.Binop(get_loc(), Gt,     _1, _3) )
# 437 "parser.ml"
               : Past.expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Past.expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Past.expr) in
    Obj.repr(
# 95 "parser.mly"
                                            ( Past.Binop(get_loc(), Le,     _1, _3) )
# 445 "parser.ml"
               : Past.expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Past.expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Past.expr) in
    Obj.repr(
# 96 "parser.mly"
                                            ( Past.Binop(get_loc(), Ge,     _1, _3) )
# 453 "parser.ml"
               : Past.expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Past.expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Past.expr) in
    Obj.repr(
# 97 "parser.mly"
                                            ( Past.Binop(get_loc(), Lor,    _1, _3) )
# 461 "parser.ml"
               : Past.expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Past.expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Past.expr) in
    Obj.repr(
# 98 "parser.mly"
                                            ( Past.Binop(get_loc(), Land,   _1, _3) )
# 469 "parser.ml"
               : Past.expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Past.expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Past.expr) in
    Obj.repr(
# 99 "parser.mly"
                                            ( Past.Binop(get_loc(), Equal,  _1, _3) )
# 477 "parser.ml"
               : Past.expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Past.expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Past.expr) in
    Obj.repr(
# 100 "parser.mly"
                                            ( Past.Binop(get_loc(), Nequal, _1, _3) )
# 485 "parser.ml"
               : Past.expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Past.expr) in
    Obj.repr(
# 101 "parser.mly"
                                            ( Past.Assign(get_loc(), _1, _3) )
# 493 "parser.ml"
               : Past.expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : Past.stmt) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : Past.block) in
    Obj.repr(
# 105 "parser.mly"
                                ( _1 :: _2 )
# 501 "parser.ml"
               : Past.block))
; (fun __caml_parser_env ->
    Obj.repr(
# 106 "parser.mly"
                                ( [] )
# 507 "parser.ml"
               : Past.block))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 4 : Past.expr) in
    let _6 = (Parsing.peek_val __caml_parser_env 1 : Past.block) in
    Obj.repr(
# 111 "parser.mly"
            ( Past.If(get_loc(), _3, _6, None) )
# 515 "parser.ml"
               : Past.stmt))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 8 : Past.expr) in
    let _6 = (Parsing.peek_val __caml_parser_env 5 : Past.block) in
    let _10 = (Parsing.peek_val __caml_parser_env 1 : Past.block) in
    Obj.repr(
# 113 "parser.mly"
            ( Past.If(get_loc(), _3, _6, Some _10) )
# 524 "parser.ml"
               : Past.stmt))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : Past.expr) in
    Obj.repr(
# 117 "parser.mly"
                                ( Past.Expr (get_loc(), _1) )
# 531 "parser.ml"
               : Past.stmt))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'decl) in
    Obj.repr(
# 118 "parser.mly"
                                ( _1 )
# 538 "parser.ml"
               : Past.stmt))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : Past.stmt) in
    Obj.repr(
# 119 "parser.mly"
                                ( _1 )
# 545 "parser.ml"
               : Past.stmt))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : Past.stmt) in
    Obj.repr(
# 120 "parser.mly"
                                ( _1 )
# 552 "parser.ml"
               : Past.stmt))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : Past.func) in
    Obj.repr(
# 121 "parser.mly"
                                ( Past.Func (get_loc(), _1) )
# 559 "parser.ml"
               : Past.stmt))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : Past.datatype) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 125 "parser.mly"
                                               ( Past.Decl(get_loc(), _1, _2, None) )
# 567 "parser.ml"
               : 'decl))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : Past.datatype) in
    let _2 = (Parsing.peek_val __caml_parser_env 2 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : Past.expr) in
    Obj.repr(
# 126 "parser.mly"
                                               ( Past.Decl(get_loc(), _1, _2, Some(_4)) )
# 576 "parser.ml"
               : 'decl))
; (fun __caml_parser_env ->
    Obj.repr(
# 131 "parser.mly"
                                                ( [] )
# 582 "parser.ml"
               : Past.arg list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Past.datatype) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Past.arg list) in
    Obj.repr(
# 132 "parser.mly"
                                                ( Past.Arg(_1, _2) :: _3 )
# 591 "parser.ml"
               : Past.arg list))
; (fun __caml_parser_env ->
    Obj.repr(
# 136 "parser.mly"
                                                ( [] )
# 597 "parser.ml"
               : Past.arg list))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : Past.datatype) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : Past.arg list) in
    Obj.repr(
# 137 "parser.mly"
                                                ( Past.Arg(_2, _3) :: _4 )
# 606 "parser.ml"
               : Past.arg list))
; (fun __caml_parser_env ->
    Obj.repr(
# 141 "parser.mly"
                                                ( [] )
# 612 "parser.ml"
               : Past.expr list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : Past.expr) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : Past.expr list) in
    Obj.repr(
# 142 "parser.mly"
                                               ( _1 :: _2 )
# 620 "parser.ml"
               : Past.expr list))
; (fun __caml_parser_env ->
    Obj.repr(
# 146 "parser.mly"
                                                ( [] )
# 626 "parser.ml"
               : Past.expr list))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : Past.expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Past.expr list) in
    Obj.repr(
# 147 "parser.mly"
                                               ( _2 :: _3 )
# 634 "parser.ml"
               : Past.expr list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 7 : Past.datatype) in
    let _2 = (Parsing.peek_val __caml_parser_env 6 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 4 : Past.arg list) in
    let _7 = (Parsing.peek_val __caml_parser_env 1 : Past.block) in
    Obj.repr(
# 152 "parser.mly"
            ( {
                name = _2; 
                args = _4;
                return_type = _1;
                body = _7 
            } )
# 649 "parser.ml"
               : Past.func))
(* Entry main *)
; (fun __caml_parser_env -> raise (Parsing.YYexit (Parsing.peek_val __caml_parser_env 0)))
|]
let yytables =
  { Parsing.actions=yyact;
    Parsing.transl_const=yytransl_const;
    Parsing.transl_block=yytransl_block;
    Parsing.lhs=yylhs;
    Parsing.len=yylen;
    Parsing.defred=yydefred;
    Parsing.dgoto=yydgoto;
    Parsing.sindex=yysindex;
    Parsing.rindex=yyrindex;
    Parsing.gindex=yygindex;
    Parsing.tablesize=yytablesize;
    Parsing.table=yytable;
    Parsing.check=yycheck;
    Parsing.error_function=parse_error;
    Parsing.names_const=yynames_const;
    Parsing.names_block=yynames_block }
let main (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 1 lexfun lexbuf : Past.block)
