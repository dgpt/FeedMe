defmodule FeedMe.Schema.Location do
  use Ecto.Schema
  import Ecto.Changeset

  schema "locations" do
    field :address, :string
    field :coordinates, FeedMe.Type.Coordinates
    field :description, :string
    field :facility_type, :string
    field :permit_status, Ecto.Enum, values: [:approved, :requested, :rejected, :expired]
    field :menu_items, :string
    field :approved_at, :utc_datetime
    field :expired_at, :utc_datetime
    field :synced_at, :utc_datetime
    belongs_to :business, FeedMe.Schema.Business
    timestamps()
  end

  def changeset(attrs) do
    %__MODULE__{}
    |> changeset(attrs)
  end

  def changeset(%__MODULE__{} = location, attrs) do
    location
    |> cast(attrs, [
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
    |> validate_required([:business_id])
  end
end
