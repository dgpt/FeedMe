defmodule FeedMe.Business do
  alias FeedMe.Repo
  alias FeedMe.Schema.Business

  def all do
    Repo.all(Business)
  end

  def get(id) do
    Repo.get(Business, id)
  end

  def update(%Business{} = business, attrs) do
    Repo.update(business, attrs)
  end
end
