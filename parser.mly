/* File parser.mly */

%{
    open Past
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
%left LOR
%left LAND
%left LT LE GT GE
%left EQUAL NEQUAL
%left ADD SUB
%left MUL DIV
%right UMINUS
%nonassoc ELSE

%start main
%type <Past.expr> expr
%type <Past.expr> value
%type <Past.stmt> stmt
%type <Past.stmt> ifstmt
%type <Past.stmt> return
%type <Past.block> block
%type <Past.func> func
%type <Past.block> main
%type <Past.datatype> datatype
%type <Past.arg list> args_tail
%type <Past.arg list> args
%type <Past.expr list> app_args
%type <Past.expr list> app_args_tail

%%

main:
    block EOF            { $1 }
;

datatype:
        | INT_KWORD         { Past.TInt }
        | BOOL_KWORD        { Past.TBool }
;

value:
        | INT                   { Past.Int $1 }
        | BOOL                  { Past.Bool $1 }
        | IDENT                 { Past.Ident $1 }
        | IDENT LPAREN app_args RPAREN { Past.App($1, $3) }
        | LPAREN expr RPAREN    { $2 }
;

return:
        | RETURN                { Past.Return None }
        | RETURN expr           { Past.Return (Some $2) }
;

expr:
        | value                             { $1 }
        | SUB expr %prec UMINUS             { Past.Unop(Neg,         $2) }
        | LNOT expr                         { Past.Unop(Lnot,        $2) }
        | expr ADD    expr                  { Past.Binop(Add,    $1, $3) }
        | expr SUB    expr                  { Past.Binop(Sub,    $1, $3) }
        | expr MUL    expr                  { Past.Binop(Mul,    $1, $3) }
        | expr DIV    expr                  { Past.Binop(Div,    $1, $3) }
        | expr LT     expr                  { Past.Binop(Lt,     $1, $3) }
        | expr GT     expr                  { Past.Binop(Gt,     $1, $3) }
        | expr LE     expr                  { Past.Binop(Le,     $1, $3) }
        | expr GE     expr                  { Past.Binop(Ge,     $1, $3) }
        | expr LOR    expr                  { Past.Binop(Lor,    $1, $3) } 
        | expr LAND   expr                  { Past.Binop(Land,   $1, $3) }
        | expr EQUAL  expr                  { Past.Binop(Equal,  $1, $3) }
        | expr NEQUAL expr                  { Past.Binop(Nequal, $1, $3) }
        | IDENT ASSIGN expr %prec ASSIGN    { Past.Assign($1, $3) }
;

block:
        | stmt block            { $1 :: $2 }
        | /* empty */           { [] }
;

ifstmt:
        | IF LPAREN expr RPAREN LBRACE block RBRACE
            { Past.If($3, $6, None) }
        | IF LPAREN expr RPAREN LBRACE block RBRACE ELSE LBRACE block RBRACE
            { Past.If($3, $6, Some $10) }
;

stmt:
        | expr SEMICOLON        { Past.Expr $1 }
        | decl SEMICOLON        { $1 }
        | return SEMICOLON      { $1 }
        | ifstmt                { $1 }
        | func                  { $1 }
;

decl:
        | datatype IDENT                    { Past.Decl($1, $2, None) }
        | datatype IDENT ASSIGN expr        { Past.Decl($1, $2, Some($4)) }
;

args:
        | datatype IDENT args_tail              { Past.Arg($1, $2) :: $3 }
        | /* empty */                           { [] }
;

args_tail:
        | COMMA datatype IDENT args_tail        { Past.Arg($2, $3) :: $4 }
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
