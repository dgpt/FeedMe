defmodule FeedMe.Repo.Migrations.AddExternalIdToLocations do
  use Ecto.Migration

  def change do
    alter table("locations") do
      add :external_id, :string
    end

    create unique_index("locations", [:external_id])
  end
end
