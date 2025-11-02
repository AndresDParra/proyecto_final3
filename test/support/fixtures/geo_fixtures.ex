defmodule MyApp.GeoFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MyApp.Geo` context.
  """

  @doc """
  Generate a location.
  """
  def location_fixture(attrs \\ %{}) do
    {:ok, location} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> MyApp.Geo.create_location()

    location
  end
end
