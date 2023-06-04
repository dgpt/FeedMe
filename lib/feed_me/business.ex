defmodule FeedMe.Business do
  use Ecto.Schema
  import Ecto.Changeset

  schema "businesses" do
    field :name, :string
    has_many :locations, FeedMe.Location
  end

  def changeset(attrs) do
    %__MODULE__{}
    |> changeset(attrs)
  end

  def changeset(%__MODULE__{} = business, attrs) do
    business
    |> validate_required([:name])
    |> cast(attrs, [:name])
  end
end
