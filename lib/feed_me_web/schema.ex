defmodule FeedMeWeb.Schema do
  use Absinthe.Schema

  import_types(Absinthe.Type.Custom)

  scalar :coordinates do
    serialize(&FeedMe.Type.Coordinates.serialize/1)
    parse(&FeedMe.Type.Coordinates.cast/1)
  end

  object :location do
    field :id, :id
    field :address, :string
    field :coordinates, :coordinates
    field :description, :string
    field :facility_type, :string
    field :permit_status, :string
    field :menu_items, :string
    field :approved_at, :datetime
    field :expired_at, :datetime
    field :synced_at, :datetime
  end

  object :business do
    field :id, :id
    field :name, :string

    field :locations, list_of(:location) do
      resolve(&FeedMeWeb.BusinessResolver.list_locations/3)
    end
  end

  query do
    field :businesses, list_of(:business) do
      resolve(&FeedMeWeb.BusinessResolver.list_businesses/3)
    end
  end
end
