defmodule MyApp.TaxiFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MyApp.Taxi` context.
  """

  @doc """
  Generate a travel_request.
  """
  def travel_request_fixture(attrs \\ %{}) do
    {:ok, travel_request} =
      attrs
      |> Enum.into(%{
        status: "some status"
      })
      |> MyApp.Taxi.create_travel_request()

    travel_request
  end
end
