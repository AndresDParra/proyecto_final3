defmodule MyApp.Repo.Migrations.CreateDrivers do
  use Ecto.Migration

  def change do
    create table(:drivers) do
      add :vehicle_model, :string
      add :vehicle_plate, :string

      timestamps(type: :utc_datetime)
    end
  end
end
