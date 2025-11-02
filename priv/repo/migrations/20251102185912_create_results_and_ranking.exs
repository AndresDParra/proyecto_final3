defmodule MyApp.Repo.Migrations.CreateResultsAndRanking do
  use Ecto.Migration

  def change do
    create table(:results_and_ranking) do
      add :date_trip, :naive_datetime
      add :passenger_points, :integer
      add :driver_points, :integer
      add :origin, :string
      add :status, :string
      add :passenger_id, references(:users, on_delete: :nothing)
      add :driver_id, references(:users, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:results_and_ranking, [:passenger_id])
    create index(:results_and_ranking, [:driver_id])
  end
end
