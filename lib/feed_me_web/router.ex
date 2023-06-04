defmodule FeedMeWeb.Router do
  use FeedMeWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  forward "/graphiql",
          Absinthe.Plug.GraphiQL,
          schema: FeedMeWeb.Schema,
          interface: :playground

  scope "/api" do
    pipe_through :api

    forward "/", Absinthe.Plug, schema: FeedMeWeb.Schema
  end
end
