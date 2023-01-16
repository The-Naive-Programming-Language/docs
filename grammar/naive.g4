grammar naive;

//
// Productions
//
prog : stmt* EOF ;

stmt : ';'
     | expr_stmt
     | 'print' '(' STRING ( ',' expr )* ')' ';' ;

expr_stmt : expr ';' ;
expr      : arith_expr
          | bool_expr
          | STRING
          | CHAR ;

arith_expr : term ;
term       : factor ( ('+'|'-') factor )* ;
factor     : arith_atom ( ('*'|'/'|'%') arith_atom )* ;
arith_atom : INT | FLOAT | '(' arith_expr ')' ;

bool_expr  : or_clause ;
or_clause  : and_clause ( 'or' and_clause )* ;
and_clause : not_clause ( 'and' not_clause )* ;
not_clause : 'not' not_clause
           | bool_atom ;
bool_atom  : TRUE
           | FALSE
           | '(' bool_expr ')' ;

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

WHITESPACE : [ \t\r\n]+ -> skip;
