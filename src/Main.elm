module Main exposing(..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import Http

import Scanner
import Parser
import Html.Events exposing (onInput)


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
  , scanner : Scanner.Model
  , parser : Parser.Model
  }


init : () -> (Model, Cmd Msg)
init _ =
  ( { input = ""
    , scanner = {} 
    , parser = {}
    }
  , Cmd.none
  )



-- UPDATE

type Msg
  = Change String


update : Msg -> Model -> (Model, Cmd Msg)
update (Change newContent) model =
  ( { model | input = newContent }
  , Cmd.none)


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
    , rightColumn model.input
    ]
  ]}




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

rightColumn : String -> Html msg
rightColumn content =
  div [ class "column" ]
    [ section [ class "hero is-light is-fullheight-with-navbar" ]
      [ div [ class "hero-body" ]
        [ div [ class "container" ]
            [ text content ]
        ]
      ]
    ]
