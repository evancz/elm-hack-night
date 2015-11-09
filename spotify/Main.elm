
import Effects exposing (Never)
import Search
import StartApp
import Task


app =
  StartApp.start
    { init = Search.init
    , update = Search.update
    , view = Search.view
    , inputs = []
    }


main =
  app.html


port tasks : Signal (Task.Task Never ())
port tasks =
  app.tasks


