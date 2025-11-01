defmodule Taxi.Address do
  use Ecto.Schema
  import Ecto.Changeset

  # Remove this alias - it's not needed and might cause issues
  # alias ElixirLS.LanguageServer.Plugins.Ecto

  # Use lowercase "schema" and plural table name
  embedded_schema do
    field(:coordinates, :float)

    timestamps()
  end

  # Add a changeset function for validation
  def changeset(address, attrs) do
    address
    |> cast(attrs, [:coordinates])
    |> validate_required([:coordinates])
  end
end
