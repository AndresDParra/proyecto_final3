defmodule Taxi.Trip do
  use Ecto.Schema
  import Ecto.Changeset

  alias Taxi.User

  schema "trips" do
    belongs_to(:user, User)
    field(:starting_point, :string)
    field(:arrival_address, :string)
    field(:price, :integer)
    field(:time, :float)
    field(:distance, :float)
    field(:active, :boolean)

    timestamps()
  end

  def changeset(trip, attrs) do
    trip
    |> cast(attrs, [
      :user_id,
      :starting_point,
      :arrival_address,
      :price,
      :time,
      :distance,
      :active
    ])
    |> validate_required([
      :user_id,
      :starting_point,
      :arrival_address,
      :price,
      :time,
      :distance,
      :active
    ])
  end
end
