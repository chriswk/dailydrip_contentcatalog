module Main exposing (..)

import Html.App as App
import Html exposing (..)
import Html.Attributes exposing (..)
import About as About
import Route as Route
import Topic as Topic
import Helpers as Helpers
import Styles
import Navigation


type alias Model =
    { route : Route.Model }


type Msg
    = NoOp


init : Maybe Route.Location -> ( Model, Cmd Msg )
init location =
    { route = Route.init location }
        ! []


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model ! []


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


view : Model -> Html Msg
view model =
    let
        compiled =
            Styles.compile Styles.css

        body =
            case model.route of
                Just (Route.Home) ->
                    About.view

                Just (Route.Topics) ->
                    Topic.view Topic.fakeTopics

                Just (Route.Topic slug) ->
                    Topic.viewTopic slug Topic.fakeTopics

                Nothing ->
                    text "Not found"
    in
        div []
            [ node "style" [ type' "text/css" ] [ text compiled.css ]
            , navigationView model
            , body
            ]


navigationView : Model -> Html Msg
navigationView model =
    let
        { id } =
            Styles.navbarNamespace

        linkListItem linkData =
            li [] [ link model.route linkData ]
    in
        nav [ id Styles.Navbar ]
            [ ul []
                (List.map linkListItem links)
            ]


link : Maybe Route.Location -> ( Route.Location, String ) -> Html msg
link currentRoute linkData =
    let
        ( loc, _ ) =
            linkData

        isActive =
            case currentRoute of
                Nothing ->
                    False

                Just route ->
                    case route of
                        Route.Topic _ ->
                            loc == Route.Topics || loc == route

                        _ ->
                            route == loc
    in
        Helpers.link isActive linkData


links : List ( Route.Location, String )
links =
    [ ( Route.Home, "Home" )
    , ( Route.Topics, "Topics" )
    ]


main : Program Never
main =
    Navigation.program (Navigation.makeParser Route.locFor)
        { init = init
        , update = update
        , urlUpdate = updateRoute
        , view = view
        , subscriptions = subscriptions
        }


updateRoute : Maybe Route.Location -> Model -> ( Model, Cmd Msg )
updateRoute route model =
    { model | route = route } ! []


styles : String
styles =
    "a.active { font-weight: bold; }"
