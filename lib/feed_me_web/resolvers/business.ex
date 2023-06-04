defmodule FeedMeWeb.BusinessResolver do
  alias FeedMe.Schema
  alias FeedMe.Business

  def list_businesses(_parent, _args, _resolution) do
    {:ok, Business.all()}
  end

  def list_locations(%Schema.Business{} = business, _args, _resolution) do
    {:ok, Business.locations(business)}
  end
end
