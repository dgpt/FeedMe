defmodule FeedMeWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :feed_me

  plug Plug.RequestId
  plug Plug.Logger

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Absinthe.Plug, schema: FeedMeWeb.Schema
end
