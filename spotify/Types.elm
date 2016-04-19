module Types (..) where


type alias Answer =
  { name : String
  }


type alias Model =
  { query : String
  , answers : List Answer
  }


type Action
  = QueryChange String
  | Query
  | RegisterAnswers (Maybe (List Answer))
