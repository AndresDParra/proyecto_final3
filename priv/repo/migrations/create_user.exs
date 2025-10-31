# priv/repo/migrations/20240215120000_create_users.exs
defmodule MyApp.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      # Integer field for taxi status (0 = false, 1 = true)
      add :taxi, :integer, default: 0

      # String fields
      add :name, :string, null: false
      # Renamed from ID to follow conventions
      add :id_code, :string, null: false
      add :password, :string, null: false

      # Integer fields
      add :score, :integer, default: 0
      # Using bigint for phone numbers
      add :phone_number, :bigint

      timestamps()
    end

    # Add indexes for better performance
    create unique_index(:users, [:id_code])
    create unique_index(:users, [:phone_number])
    create index(:users, [:taxi])
  end
end
