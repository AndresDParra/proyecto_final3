defmodule MyApp.RankingFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MyApp.Ranking` context.
  """

  @doc """
  Generate a result.
  """
  def result_fixture(attrs \\ %{}) do
    {:ok, result} =
      attrs
      |> Enum.into(%{
        date_trip: ~N[2025-10-31 22:07:00],
        driver_points: 42,
        origin: "some origin",
        passenger_points: 42,
        status: "some status"
      })
      |> MyApp.Ranking.create_result()

    result
  end
end
