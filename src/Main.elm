module Main exposing (..)

import LoxParser exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import Http
import Node exposing (..)
import String exposing (fromFloat, fromInt)


-- MAIN


type alias Document msg =
  { title : String
  , body : List (Html msg)
  }


main =
  Browser.document
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }



-- MODEL


type alias Model =
  { input : String
  , tokens : List Token
  , statements : Maybe Expr  -- FIXME
  }



init : () -> ( Model, Cmd Msg )
init _ =
  ( { input = ""
    , tokens = []
    , statements = Nothing
    }
  , Cmd.none
  )



-- UPDATE


type Msg
  = Change String


update : Msg -> Model -> ( Model, Cmd Msg )
update (Change newContent) model =
  ( { model
    | input = newContent
    , statements = parse newContent}
  , Cmd.none
  )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none



-- VIEW


view : Model -> Document Msg
view model =
  { title = "Elmox"
  , body =
    [ header "Parse"
    , div [ class "columns is-gapless" ]
      [ leftColumn
      , rightColumn model.statements
      ]
    ]
  }


header : String -> Html msg
header buttonText =
  section [ class "hero is-primary" ]
    [ div [ class "hero-head" ]
      [ nav [ class "navbar" ]
        [ div [ class "container" ]
          [ div [ class "navbar-brand" ]
            [ a [ class "navbar-item" ]
              [ h1 [ class "title" ]
                [ text "ELMOX" ]
              ]
            , span [ class "navbar-burger burger", attribute "data-target" "navbarMenuHeroA" ]
              [ span []
                []
              , span []
                []
              , span []
                []
              ]
            ]
          , div [ class "navbar-menu", id "navbarMenuHeroA" ]
            [ div [ class "navbar-end" ]
              [ a [ class "navbar-item is-active" ]
                [ text "Home" ]
              , a [ class "navbar-item" ]
                [ text "Examples" ]
              , a [ class "navbar-item" ]
                [ text "Documentation" ]
              , span [ class "navbar-item" ]
                [ a [ class "button is-primary is-inverted" ]
                  [ span [ class "icon" ]
                    [ i [ class "fas fa-caret-square-right" ]
                      []
                    ]
                  , span []
                    [ text buttonText ]
                  ]
                ]
              ]
            ]
          ]
        ]
      ]
    ]


leftColumn : Html Msg
leftColumn =
  div [ class "column" ]
    [ section [ class "hero is-dark is-fullheight-with-navbar" ]
      [ div [ class "hero-body left-column" ]
        [ textarea [ class "textarea", placeholder "Insert Lox code here", onInput Change ]
          []
        ]
      ]
    ]


rightColumn : Maybe Expr -> Html msg
rightColumn content =
  div [ class "column" ]
    [ section [ class "hero is-light is-fullheight-with-navbar" ]
      [ div [ class "hero-body" ]
        [ div [ class "container" ]
          [ tree content ]
        ]
      ]
    ]


tree : Maybe Expr -> Html msg
tree str =
  case str of
    Nothing ->
      div [] []
    Just expr ->
      div [ class "tree" ]
        [ ul []
          [ li []
            [ a [ href "#" ]
              [ text "Program" ]
            , ul []
              [ li []
                [ a [ href "#" ]
                  [ text "Child" ]
                , ul []
                  [ leaf "Grand Child"
                  , viewExpr expr
                  ]
                ]
              , li []
                [ a [ href "#" ]
                  [ text "Child" ]
                , ul []
                  [ li []
                    [ a [ href "#" ]
                      [ text "Grand Child" ]
                    , ul []
                      [ li []
                        [ a [ href "#" ]
                          [ text "Grand Grand Child" ]
                        ]
                      ]
                    ]
                  , li []
                    [ a [ href "#" ]
                      [ text "Grand Child" ]
                    ]
                  ]
                ]
              ]
            ]
          ]
        ]


branch : String -> List (Html msg) -> Html msg
branch node children =
  case children of
    [] ->
      li []
        [ a [ href "#" ]
          [ text node ]
        ]
    _ ->
      li []
        [ a [ href "#" ]
          [ text node ]
        , ul []
          children
        ]


leaf : String -> Html msg
leaf str = branch str []


viewExpr : Expr -> Html msg
viewExpr expr =
  case expr of
    Literal e -> viewLiteralExpr e
    Variable e -> viewVariableExpr e
    Grouping e -> viewGroupingExpr e
    _ -> leaf "Not implemented"


viewLiteralExpr : LiteralExpr -> Html msg
viewLiteralExpr expr =
  case expr of
    String string -> leaf <| "\"" ++ string ++ "\""
    Int int -> leaf (fromInt int)
    Float float -> leaf (fromFloat float)
    Bool bool -> if bool then leaf "true" else leaf "false"
    Nil -> leaf "nil"


viewVariableExpr : VariableExpr -> Html msg
viewVariableExpr (VariableExpr token) =
  leaf token

viewGroupingExpr : GroupingExpr -> Html msg
viewGroupingExpr (GroupingExpr expr) =
  branch "()" [(viewExpr expr)]


