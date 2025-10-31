defmodule Taxi.Address do
  use Ecto.Schema
  import Ecto.Changeset

  # Remove this alias - it's not needed and might cause issues
  # alias ElixirLS.LanguageServer.Plugins.Ecto

  # Use lowercase "schema" and plural table name
  embedded_schema do
    field(:street, :string)
    field(:avenue, :string)
    field(:zip_code, :integer)

    timestamps()
  end

  # Add a changeset function for validation
  def changeset(address, attrs) do
    address
    |> cast(attrs, [:street, :avenue, :zip_code])
    |> validate_required([:street, :avenue, :zip_code])
  end
end
