module Scanner exposing (..)

import Token exposing (TokenType)

import Dict exposing (Dict)

-- MODEL
type alias Model = {}


-- UPDATE



-- VIEW
        -- keywords.put("and",    AND);
        -- keywords.put("class",  CLASS);
        -- keywords.put("else",   ELSE);
        -- keywords.put("false",  FALSE);
        -- keywords.put("for",    FOR);
        -- keywords.put("fun",    FUN);
        -- keywords.put("if",     IF);
        -- keywords.put("nil",    NIL);
        -- keywords.put("or",     OR);
        -- keywords.put("print",  PRINT);
        -- keywords.put("return", RETURN);
        -- keywords.put("super",  SUPER);
        -- keywords.put("this",   THIS);
        -- keywords.put("true",   TRUE);
        -- keywords.put("var",    VAR);
        -- keywords.put("while",  WHILE);
        -- keywords.put("break",  BREAK);


keywords : Dict String TokenType
keywords =
  Dict.fromList
    [ ("and",   Token.AND) 
    , ("class", Token.CLASS)
    , ("else",  Token.ELSE)
    , ("false", Token.FALSE)
    , ("for",   Token.FOR)
    , ("fun",   Token.FUN)
    , ("if",    Token.IF)
    , ("nil",   Token.NIL)
    , ("or",    Token.OR)
    , ("print", Token.PRINT)
    , ("return",Token.RETURN)
    , ("super", Token.SUPER)
    , ("this",  Token.THIS)
    , ("true",  Token.TRUE)
    , ("var",   Token.VAR)
    , ("while", Token.WHILE)
    , ("break", Token.BREAK)
    ]