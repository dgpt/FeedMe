defmodule FeedMe.Location do
  use Ecto.Schema
  import Ecto.Changeset

  schema "locations" do
    field :address, :string
    field :coordinates, FeedMe.Types.Coordinates
    belongs_to :business, FeedMe.Business
  end

  def changeset(attrs) do
    %__MODULE__{}
    |> changeset(attrs)
  end

  def changeset(%__MODULE__{} = location, attrs) do
    location
    |> validate_required([:name, :business_id])
  end
end
