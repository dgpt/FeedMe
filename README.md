# ReadMe for FeedMe

A GraphQL API for the open source San Francisco food truck data.

# Get Started

  * `mix setup` to install and setup dependencies
  * `mix phx.server` or inside IEx with `iex -S mix phx.server`
  * Visit [`localhost:4000/graphiql`](http://localhost:4000/graphiql) from your browser.
      or make GQL requests to [`localhost:4000/api`](http://localhost:4000/api)

# Architecture

This is a fairly standard Phoenix app. `lib/feed_me/` houses all of the business logic and
interfaces with the database. `lib/feed_me_web/` handles client interactions, so it contains
all of the GraphQL schemas and resolvers.

## DB Schemas
Ecto Schemas are found in `lib/feed_me/schema/` and have a corresponding service module
in `lib/feed_me/`. The service module is effectively the public API into the FeedMe application.

## GQL Schemas
Absinthe Schemas are currently located in `lib/feed_me_web/schema.ex`.
These will likely need to be split out into multiple files, but this app is fairly simple, so it didn't feel necessary yet.

## GQL Resolvers
Absinthe Resolvers are located in `lib/feed_me_web/resolvers`. The resolver's responsibility is to parse
arguments and pass them to the appropriate service module under `FeedMe`.

## Custom Types
Custom Ecto Types can be found in `lib/feed_me/type/`.
They may have an additional `serialize` method utilized by custom scalar types in the GraphQL schema.
