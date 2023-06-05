defmodule FeedMe.Repo.Migrations.CreateTables do
  use Ecto.Migration

  def change do
    create table("businesses") do
      add :name, :string
      timestamps()
    end

    create table("locations") do
      add :address, :string
      add :coordinates, :map
      add :business_id, references("businesses", on_delete: :delete_all)
      add :description, :string
      add :facility_type, :string
      add :permit_status, :string
      add :menu_items, :string
      add :approved_at, :utc_datetime
      add :synced_at, :utc_datetime
      add :expired_at, :utc_datetime

      timestamps()
    end
  end
end
