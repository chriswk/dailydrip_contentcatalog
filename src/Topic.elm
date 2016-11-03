module Topic exposing (..)

import Html exposing (..)
import Helpers exposing (link)
import Route as Route


view : List Topic -> Html msg
view topics =
    ul []
        (List.map topicListItemView topics)


viewTopic slug topics =
    let
        currentTopic =
            List.filter (\t -> t.slug == slug) topics
                |> List.head
    in
        case currentTopic of
            Nothing ->
                text "Topic not found"

            Just topic ->
                text ("This is the " ++ topic.slug ++ " topic")


topicListItemView : Topic -> Html msg
topicListItemView topic =
    li [] [ link False ( Route.Topic topic.slug, topic.title ) ]


type alias Topic =
    { id : Int
    , title : String
    , slug : String
    }


fakeTopics : List Topic
fakeTopics =
    [ { id = 1, title = "Elixir", slug = "elixir" }
    , { id = 2, title = "Elm", slug = "elm" }
    ]
