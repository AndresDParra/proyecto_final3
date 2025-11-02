defmodule MyApp.Repo.Migrations.CreateTravelRequests do
  use Ecto.Migration

  def change do
    create table(:travel_requests) do
      add :status, :string
      add :passenger_id, references(:users, on_delete: :nothing)
      add :driver_id, references(:users, on_delete: :nothing)
      add :origin_location_id, references(:locations, on_delete: :nothing)
      add :destination_location_id, references(:locations, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:travel_requests, [:passenger_id])
    create index(:travel_requests, [:driver_id])
    create index(:travel_requests, [:origin_location_id])
    create index(:travel_requests, [:destination_location_id])
  end
end
