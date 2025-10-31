defmodule MyApp.User do
  use Ecto.Schema

  schema "users" do
    field :is_taxi, :boolean
    field :name, :string
    # Note: lowercase 'id' is more conventional
    field :ID, :string
    field :score, :integer
    field :password, :string
    field :phone_number, :integer
    # Added missing type

    timestamps()
  end
end
