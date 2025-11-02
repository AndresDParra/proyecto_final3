defmodule MyApp.Ranking.Result do
  use Ecto.Schema
  import Ecto.Changeset

  schema "results_and_ranking" do
    field :date_trip, :naive_datetime
    field :passenger_points, :integer
    field :driver_points, :integer
    field :origin, :string
    field :status, :string
    field :passenger_id, :id
    field :driver_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(result, attrs) do
    result
    |> cast(attrs, [:date_trip, :passenger_points, :driver_points, :origin, :status])
    |> validate_required([:date_trip, :passenger_points, :driver_points, :origin, :status])
  end
end
