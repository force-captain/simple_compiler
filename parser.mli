type token =
  | INT of (
# 7 "parser.mly"
        int
# 6 "parser.mli"
)
  | IDENT of (
# 8 "parser.mly"
        string
# 11 "parser.mli"
)
  | BOOL of (
# 9 "parser.mly"
        bool
# 16 "parser.mli"
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

val main :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Past.block
