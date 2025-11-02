defmodule MyApp.Taxi.TravelRequest do
  use Ecto.Schema
  import Ecto.Changeset

  schema "travel_requests" do
    field :status, :string
    field :passenger_id, :id
    field :driver_id, :id
    field :origin_location_id, :id
    field :destination_location_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(travel_request, attrs) do
    travel_request
    |> cast(attrs, [:status])
    |> validate_required([:status])
  end
end
