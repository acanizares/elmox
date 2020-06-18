module LoxParser exposing (parse)

import Parser exposing (..)
import Parser.Advanced as A
import Dict exposing (Dict)
import Html.Attributes exposing (id)
import Node exposing (..)
import Set
--import Token exposing (..)


parse : String -> Maybe Expr
parse str =
  case (run expression str) of
    Ok expr -> Just expr
    Err _ -> Nothing

literalExpr : Parser LiteralExpr
literalExpr =
  oneOf
    [ map (\_ -> Bool True) (keyword "true")
    , map (\_ -> Bool False) (keyword "false")
    , map (\_ -> Nil) (keyword "nil")
    , number
      { int = Just Int
      , hex = Nothing
      , octal = Nothing
      , binary = Nothing
      , float = Just Float
      }
    , succeed String
       |. symbol "\""
       |= getChompedString (A.chompUntil (A.Token "\"" (Problem "Unterminated string.")))
       |. symbol "\""
    ]

variableExpr : Parser VariableExpr
variableExpr =
  variable
    { start = Char.isLower
    , inner = \c -> Char.isAlphaNum c || c == '_'
    , reserved = keywords
    }
  |> map VariableExpr

groupingExpr : Parser GroupingExpr
groupingExpr =
  succeed GroupingExpr
    |. symbol "("
    |= lazy (\_ -> expression)  -- avoid cyclic dependance
    |. A.symbol (A.Token ")" (Expecting "')' after expression."))

primary : Parser Expr
primary =
  oneOf
    [ map (\e -> Literal e) literalExpr
    , map (\e -> Variable e) variableExpr
    , map (\e -> Grouping e) groupingExpr
    ]

expression : Parser Expr
expression =
  oneOf
    [ primary
    ]

keywords =
  Set.fromList
    [ "and"
    , "class"
    , "else"
    , "false"
    , "for"
    , "fun"
    , "if"
    , "nil"
    , "or"
    , "print"
    , "return"
    , "super"
    , "this"
    , "true"
    , "var"
    , "while"
    , "break"
    ]