%{
    open Ast
%}

%token <int> INT
%token <string> IDENT
%token <bool> BOOL
%token INT_KWORD BOOL_KWORD 
%token ASSIGN

%token SEMICOLON
%token COMMA
%token RETURN
%token IF ELSE

%token LOR LAND

%token EQUAL NEQUAL
%token LT LE GT GE

%token ADD SUB MUL DIV

%token LPAREN RPAREN
%token LBRACE RBRACE

%token PRINT

%token EOF
%right ASSIGN
%left LOR LAND LNOT
%left LT LE GT GE
%left EQUAL NEQUAL
%left ADD SUB
%left MUL DIV
%right UMINUS
%nonassoc ELSE

%start main
%type <Ast.expr> expr
%type <Ast.expr> value
%type <Ast.stmt> stmt
%type <Ast.stmt> ifstmt
%type <Ast.stmt> return
%type <Ast.block> block
%type <Ast.func> func
%type <Ast.block> main
%type <Ast.datatype> datatype
%type <Ast.arg list> args_tail
%type <Ast.arg list> args
%type <Ast.expr list> app_args
%type <Ast.expr list> app_args_tail

%%

main:
    block EOF            { $1 }
;

datatype:
        | INT_KWORD         { Ast.TInt }
        | BOOL_KWORD        { Ast.TBool }
;

value:
        | INT                   { Ast.Int $1 }
        | BOOL                  { Ast.Bool $1 }
        | IDENT                 { Ast.Ident $1 }
        | IDENT LPAREN app_args RPAREN { Ast.App($1, $3) }
        | LPAREN expr RPAREN    { $2 }
;

return:
        | RETURN                { Ast.Return None }
        | RETURN expr           { Ast.Return (Some $2) }
;

expr:
        | value                             { $1 }
        | SUB expr %prec UMINUS             { Ast.Unop(Neg,         $2) }
        | LNOT expr                         { Ast.Unop(Lnot,        $2) }
        | expr ADD    expr                  { Ast.Binop(Add,    $1, $3) }
        | expr SUB    expr                  { Ast.Binop(Sub,    $1, $3) }
        | expr MUL    expr                  { Ast.Binop(Mul,    $1, $3) }
        | expr DIV    expr                  { Ast.Binop(Div,    $1, $3) }
        | expr LT     expr                  { Ast.Binop(Lt,     $1, $3) }
        | expr GT     expr                  { Ast.Binop(Gt,     $1, $3) }
        | expr LE     expr                  { Ast.Binop(Le,     $1, $3) }
        | expr GE     expr                  { Ast.Binop(Ge,     $1, $3) }
        | expr LOR    expr                  { Ast.Binop(Lor,    $1, $3) } 
        | expr LAND   expr                  { Ast.Binop(Land,   $1, $3) }
        | expr EQUAL  expr                  { Ast.Binop(Equal,  $1, $3) }
        | expr NEQUAL expr                  { Ast.Binop(Nequal, $1, $3) }
        | IDENT ASSIGN expr %prec ASSIGN    { Ast.Assign($1, $3) }
;

block:
        | stmt block            { $1 :: $2 }
        | /* empty */           { [] }
;

ifstmt:
        | IF LPAREN expr RPAREN LBRACE block RBRACE
            { Ast.If($3, $6, None) }
        | IF LPAREN expr RPAREN LBRACE block RBRACE ELSE LBRACE block RBRACE
            { Ast.If($3, $6, Some $10) }
;

stmt:
        | expr SEMICOLON        { Ast.Expr $1 }
        | decl SEMICOLON        { $1 }
        | return SEMICOLON      { $1 }
        | ifstmt                { $1 }
        | func                  { $1 }
;

decl:
        | datatype IDENT                    { Ast.Decl($1, $2, None) }
        | datatype IDENT ASSIGN expr        { Ast.Decl($1, $2, Some($4)) }
;

args:
        | datatype IDENT args_tail              { Ast.Arg($1, $2) :: $3 }
        | /* empty */                           { [] }
;

args_tail:
        | COMMA datatype IDENT args_tail        { Ast.Arg($2, $3) :: $4 }
        | /* empty */                           { [] }
;

app_args:
        | expr app_args_tail                   { $1 :: $2 }
        | /* empty */                           { [] }
;

app_args_tail:
        | COMMA expr app_args_tail             { $2 :: $3 }
        | /* empty */                           { [] }
;

func:
        | datatype IDENT LPAREN args RPAREN LBRACE block RBRACE
            { Func {
                name = $2; 
                args = $4;
                return_type = $1;
                body = $7 
            } }
;
