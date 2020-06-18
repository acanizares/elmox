module Token exposing (..)

type alias Token = 
  { tokenType : TokenType
  , lexeme : String
  , line : Int
  , column : Int
  , literal : Literal
  }
  
type Literal
  = LiteralInt Int
  | LiteralFloat Float
  | LiteralStr String
  | LiteralBool Bool
  | Nil

type TokenType
  -- Single-character tokens.
  = LEFT_PAREN     
  | RIGHT_PAREN 
  | LEFT_BRACE
  | RIGHT_BRACE
  | COMMA 
  | DOT 
  | MINUS 
  | PLUS 
  | SEMICOLON
  | COLON 
  | SLASH 
  | STAR 
  | QUESTION
  -- One or two character tokens.
  | BANG 
  | BANG_EQUAL
  | EQUAL
  | EQUAL_EQUAL
  | GREATER
  | GREATER_EQUAL
  | LESS
  | LESS_EQUAL
  -- Literals.
  | IDENTIFIER
  | STRING
  | NUMBER
  -- Keywords.
  | AND
  | CLASS
  | ELSE
  | FALSE
  | FUN
  | FOR
  | IF
  | NIL
  | OR
  | PRINT
  | RETURN
  | SUPER
  | THIS
  | TRUE
  | VAR
  | WHILE
  | BREAK

  | EOF
