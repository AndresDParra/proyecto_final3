defmodule MyApp.Auth.Driver do
  use Ecto.Schema
  import Ecto.Changeset

  schema "drivers" do
    field :vehicle_model, :string
    field :vehicle_plate, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(driver, attrs) do
    driver
    |> cast(attrs, [:vehicle_model, :vehicle_plate])
    |> validate_required([:vehicle_model, :vehicle_plate])
  end
end
