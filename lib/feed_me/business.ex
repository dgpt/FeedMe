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
    business
    |> Business.changeset(attrs)
    |> Repo.update()
  end

  def upsert(attrs) do
    Business.changeset(attrs)
    |> Repo.insert(on_conflict: :replace_all, conflict_target: :name)
  end

  def locations(%Business{} = business) do
    business
    |> Repo.preload(:locations)
  end
end
