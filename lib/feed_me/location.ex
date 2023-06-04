defmodule FeedMe.Location do
  alias FeedMe.Repo
  alias FeedMe.Schema.Location

  def all do
    Repo.all(Location)
  end

  def get(id) do
    Repo.get(Location, id)
  end

  def update(%Location{} = location, attrs) do
    location
    |> Location.changeset(attrs)
    |> Repo.update()
  end
end
