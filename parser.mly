%{

let get_loc = Parsing.symbol_start_pos

%}

%token <int> INT
%token <string> IDENT
%token <bool> BOOL
%token INT_KWORD BOOL_KWORD UNIT_KWORD
%token ASSIGN

%token SEMICOLON
%token COMMA
%token RETURN
%token IF ELSE

%token LOR LAND LNOT

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
%type <Past.expr> expr
%type <Past.expr> value
%type <Past.stmt> stmt
%type <Past.stmt> ifstmt
%type <Past.stmt> ret
%type <Past.block> block
%type <Past.func> func
%type <Past.block> main
%type <Past.datatype> datatype
%type <Past.arg list> args_tail
%type <Past.arg list> args
%type <Past.expr list> app_args
%type <Past.expr list> app_args_tail
%type <Past.datatype> datatype_ex

%%

main:
    block EOF            { $1 }
;

datatype_ex:
        | INT_KWORD         { Past.IntType }
        | BOOL_KWORD        { Past.BoolType }
;

datatype:
        | datatype_ex       { $1 }
        | UNIT_KWORD        { Past.UnitType }
;

value:
        | INT                   { Past.Int (get_loc(), $1) }
        | BOOL                  { Past.Bool (get_loc(), $1) }
        | IDENT                 { Past.Ident (get_loc(), $1) }
        | IDENT LPAREN app_args RPAREN { Past.App(get_loc(), $1, $3) }
        | LPAREN expr RPAREN    { $2 }
;

ret:
        | RETURN                { Past.Return (get_loc(), None) }
        | RETURN expr           { Past.Return (get_loc(), (Some $2)) }
;

expr:
        | value                             { $1 }
        | SUB expr %prec UMINUS             { Past.Unop(get_loc(), Neg,         $2) }
        | LNOT expr                         { Past.Unop(get_loc(), Not,         $2) }
        | expr ADD    expr                  { Past.Binop(get_loc(), Add,    $1, $3) }
        | expr SUB    expr                  { Past.Binop(get_loc(), Sub,    $1, $3) }
        | expr MUL    expr                  { Past.Binop(get_loc(), Mul,    $1, $3) }
        | expr DIV    expr                  { Past.Binop(get_loc(), Div,    $1, $3) }
        | expr LT     expr                  { Past.Binop(get_loc(), Lt,     $1, $3) }
        | expr GT     expr                  { Past.Binop(get_loc(), Gt,     $1, $3) }
        | expr LE     expr                  { Past.Binop(get_loc(), Le,     $1, $3) }
        | expr GE     expr                  { Past.Binop(get_loc(), Ge,     $1, $3) }
        | expr LOR    expr                  { Past.Binop(get_loc(), Lor,    $1, $3) } 
        | expr LAND   expr                  { Past.Binop(get_loc(), Land,   $1, $3) }
        | expr EQUAL  expr                  { Past.Binop(get_loc(), Equal,  $1, $3) }
        | expr NEQUAL expr                  { Past.Binop(get_loc(), Nequal, $1, $3) }
        | IDENT ASSIGN expr %prec ASSIGN    { Past.Assign(get_loc(), $1, $3) }
;

block:
        | stmt block            { $1 :: $2 }
        | /* empty */           { [] }
;

ifstmt:
        | IF LPAREN expr RPAREN LBRACE block RBRACE
            { Past.If(get_loc(), $3, $6, None) }
        | IF LPAREN expr RPAREN LBRACE block RBRACE ELSE LBRACE block RBRACE %prec ELSE
            { Past.If(get_loc(), $3, $6, Some $10) }
;

stmt:
        | expr SEMICOLON        { Past.Expr (get_loc(), $1) }
        | decl SEMICOLON        { $1 }
        | ret SEMICOLON         { $1 }
        | ifstmt                { $1 }
        | func                  { Past.Func (get_loc(), $1) }
;

decl:
        | datatype_ex IDENT                    { Past.Decl(get_loc(), $1, $2, None) }
        | datatype_ex IDENT ASSIGN expr        { Past.Decl(get_loc(), $1, $2, Some($4)) }
;


args:
        | /* empty */                           { [] }
        | datatype_ex IDENT args_tail           { Past.Arg($1, $2) :: $3 }
;

args_tail:
        | /* empty */                           { [] }
        | COMMA datatype_ex IDENT args_tail     { Past.Arg($2, $3) :: $4 }
;

app_args:
        | /* empty */                           { [] }
        | expr app_args_tail                   { $1 :: $2 }
;

app_args_tail:
        | /* empty */                           { [] }
        | COMMA expr app_args_tail             { $2 :: $3 }
;

func:
        | datatype IDENT LPAREN args RPAREN LBRACE block RBRACE
            { {
                name = $2; 
                args = $4;
                return_type = $1;
                body = $7 
            } }
;
