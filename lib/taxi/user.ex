defmodule Taxi.User do
  use Ecto.Schema
  import Ecto.Changeset

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

  def changeset(trip, attrs) do
    trip
    |> cast(attrs, [:user_id, :starting_point, :arrival_address, :price])
    |> validate_required([:user_id, :starting_point, :arrival_address, :price])
  end
end
