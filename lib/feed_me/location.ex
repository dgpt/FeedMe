defmodule FeedMe.Location do
  use Ecto.Schema
  import Ecto.Changeset

  schema "locations" do
    field :address, :string
    field :coordinates, FeedMe.Types.Coordinates
    field :description, :string
    field :facility_type, :string
    field :permit_status, Ecto.Enum, values: [:approved, :requested, :rejected, :expired]
    field :menu_items, :string
    field :approved_at, Ecto.DateTime
    field :expired_at, Ecto.DateTime
    field :synced_at, Ecto.DateTime
    belongs_to :business, FeedMe.Business
  end

  def changeset(attrs) do
    %__MODULE__{}
    |> changeset(attrs)
  end

  def changeset(%__MODULE__{} = location, attrs) do
    location
    |> validate_required([:name, :business_id])
    |> cast(attrs, [
      :name,
      :business_id,
      :address,
      :coordinates,
      :description,
      :facility_type,
      :permit_status,
      :menu_items,
      :approved_at,
      :expired_at,
      :synced_at
    ])
  end
end
