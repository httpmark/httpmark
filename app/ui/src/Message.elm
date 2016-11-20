module Message exposing (..)

type Message
  = ChangeQuery String
  | Fetch
  | Receive String
