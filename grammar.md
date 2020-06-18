# Lox Grammar

```haskell
program        → declaration* EOF ;

declaration    → funDecl
               | varDecl
               | statement ;

statement      → exprStmt
               | forStmt
               | ifStmt
               | printStmt
               | returnStmt
               | whileStmt
               | block ;

loopBody       → loopBlock;
               | breakStmt
               | statement

funDecl        → "fun" function ;
function       → IDENTIFIER "(" parameters? ")" block ;
parameters     → IDENTIFIER ( "," IDENTIFIER )* ;
varDecl        → "var" IDENTIFIER ( "=" expression )? ";" ;
exprStmt       → expression ";" ;
forStmt        → "for" "(" ( varDecl | exprStmt | ";" )
                           expression? ";"
                           expression? ")" loopBody ;
ifStmt         → "if" "(" expression ")" statement ( "else" statement )? ;
printStmt      → "print" expression ";" ;
returnStmt     → "return" expression? ";" ;
whileStmt      → "while" "(" expression ")" loopBody ;
block          → "{" declaration* "}" ;
loopBlock      → "{" (varDecl | loopBody)* "}" ;
breakStmt      → "break" ";" ;

expression     → comma ;
comma          → assignment ( "," assignment )* ;
assignment     → IDENTIFIER "=" assignment
               | conditional ;
conditional    → logic_or ( "?" comma ":" conditional )? ;
logic_or       → logic_and ( "or" logic_and )* ;
logic_and      → equality ( "and" equality )* ;
equality       → comparison ( ( "!=" | "==" ) comparison )* ;
comparison     → addition ( ( ">" | ">=" | "<" | "<=" ) addition )* ;
addition       → multiplication ( ( "-" | "+" ) multiplication )* ;
multiplication → unary ( ( "/" | "*" ) unary )* ;
unary          → ( "!" | "-" ) unary
               | call ;
call           → primary ( "(" arguments? ")" )* ;
arguments      → assignment ( "," assignment )* ;
primary        → NUMBER | STRING | "false" | "true" | "nil"
               | "(" expression ")"
               | IDENTIFIER
               | lambda
              -- Error productions...
               | ( "!=" | "==" ) equality
               | ( ">" | ">=" | "<" | "<=" ) comparison
               | ( "+" ) addition
               | ( "/" | "*" ) multiplication ;
lambda         -> "fun" "(" parameters? ")" block ;
```