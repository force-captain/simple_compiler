(* File lexer.mll *)
{
    open Parser
    open Lexing

let next_line lexbuf = 
    let pos = lexbuf.lex_curr_p in
    lexbuf.lex_curr_p <-
        { pos with pos_bol = lexbuf.lex_curr_pos;
                   pos_lnum = pos.pos_lnum + 1
        }
}


let newline = ( '\n' | "\r\n" )
let ident_reg_exp = ['A'-'Z' 'a'-'z' '_']+ ['0'-'9' 'A'-'Z' 'a'-'z' '_']* 
let int_reg_exp = ['0'-'9']+

    rule token = parse
      | [' ' '\t']      { token lexbuf }
      | newline         { next_line lexbuf; token lexbuf }
      | '+'             { ADD }
      | '-'             { SUB }
      | '*'             { MUL }
      | '/'             { DIV }
      | "||"            { LOR }
      | "&&"            { LAND }
      | "if"            { IF }
      | "else"          { ELSE }
      | "int"           { INT_KWORD }
      | "bool"          { BOOL_KWORD }
      | "return"        { RETURN }
      | "true"          { BOOL true }
      | "false"         { BOOL false }
      | "=="            { EQUAL }
      | "!="            { NEQUAL }
      | '!'             { LNOT }
      | "<="            { LE }
      | ","             { COMMA }
      | ">="            { GE }
      | '<'             { LT }
      | '>'             { GT }
      | '('             { LPAREN }
      | ')'             { RPAREN }
      | '{'             { LBRACE }
      | '}'             { RBRACE }
      | ';'             { SEMICOLON }
      | '='             { ASSIGN }
      | "/*"            { comment lexbuf; token lexbuf }
      | eof             { EOF }
      | int_reg_exp     { INT (int_of_string (Lexing.lexeme lexbuf)) }
      | ident_reg_exp   { IDENT (Lexing.lexeme lexbuf) }
      | _               { Errors.complain ("Lexer: Illegal character " ^ (Char.escaped(Lexing.lexeme_char lexbuf 0))) }

and comment = parse
    | "*/" { () }
    | newline {next_line lexbuf; comment lexbuf }
    | "/*" {comment lexbuf; comment lexbuf }
    | eof  { failwith "EOF reached inside comment" }
    | _ { comment lexbuf }
