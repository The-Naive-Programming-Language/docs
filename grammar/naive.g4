grammar naive;

//
// Productions
//
prog : stmt* EOF ;

stmt : ';'
     | decl_stmt
     | assign_stmt
     | block
     | if_else
     | while_loop
     | return_stmt
     | expr_stmt
     | COMMENT
     ;

decl_stmt  : 'let' IDENT ( '=' init )? ';'
           | 'fn' IDENT '(' ident_list? ')' block
           ;
init       : expr ;
ident_list : IDENT ( ',' IDENT )* ;

assign_stmt : IDENT '=' expr ';' ;

block : '{' stmt* '}' ;

if_else : 'if' expr block ( 'else' ( if_else | block ) )? ;

while_loop : 'while' expr block ;

return_stmt : 'return' expr ;

expr_stmt  : expr ';' ;
expr_list  : expr ( ',' expr )* ;
expr       : lambda ;
lambda     : 'fn' '(' ident_list ')' '->' expr
           | 'fn' '(' ident_list ')' block
           | logical
           ;
logical    : or_clause ;
or_clause  : and_clause ( 'or' and_clause )* ;
and_clause : relational ( 'and' relational )* ;
relational : term ( ('=='|'/='|'<'|'>'|'<='|'>=') term )* ;
term       : factor ( ('+'|'-') factor )* ;
factor     : unary ( ('*'|'/'|'%') unary )* ;
unary      : ('not'|'-') unary
           | call ;
call       : IDENT '(' expr_list? ')'
           | primary
           ;
primary    : INT | FLOAT | TRUE | FALSE | CHAR | STRING | IDENT | '(' expr ')' ;

//
// Tokens
//
INT : DEC | HEX | OCT | BIN ;
DEC : [0-9]+ ;
HEX : '0x' [0-9A-Fa-f]+ ;
OCT : '0o' [0-7]+ ;
BIN : '0b' [0-1]+ ;

FLOAT : [0-9]+ '.' [0-9]+ ( ('e'|'E') ('+'|'-')? [0-9]+ )? ;

TRUE  : 'true' ;
FALSE : 'false' ;
AND   : 'and' ;
OR    : 'or' ;
NOT   : 'not' ;

CHAR   : '\'' . '\'' ;
STRING : '"' .*? '"' ;

IDENT : [A-Za-z_][0-9A-Za-z_]* ;

COMMENT : '#' .*? ('\n'|EOF) ;

WHITESPACE : [ \t\r\n]+ -> skip;
