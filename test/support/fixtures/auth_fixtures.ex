defmodule MyApp.AuthFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MyApp.Auth` context.
  """

  @doc """
  Generate a role.
  """
  def role_fixture(attrs \\ %{}) do
    {:ok, role} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> MyApp.Auth.create_role()

    role
  end

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        name: "some name",
        password: "some password",
        username: "some username"
      })
      |> MyApp.Auth.create_user()

    user
  end

  @doc """
  Generate a driver.
  """
  def driver_fixture(attrs \\ %{}) do
    {:ok, driver} =
      attrs
      |> Enum.into(%{
        vehicle_model: "some vehicle_model",
        vehicle_plate: "some vehicle_plate"
      })
      |> MyApp.Auth.create_driver()

    driver
  end
end
