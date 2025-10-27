# lib/taxi/trip_service.ex
defmodule Taxi.TripService do
  alias Taxi.{Repo, Trip, Accounts, Address}

  def create_trip(user_id, starting_point_attrs, arrival_address_attrs, price) do
    # Start a transaction to ensure all operations succeed or fail together
    Repo.transaction(fn ->
      with {:ok, user} <- get_user(user_id),
           {:ok, starting_point} <- create_or_find_address(starting_point_attrs),
           {:ok, arrival_address} <- create_or_find_address(arrival_address_attrs),
           {:ok, trip} <- insert_trip(user, starting_point, arrival_address, price) do
        trip
      else
        {:error, error} -> Repo.rollback(error)
      end
    end)
  end

  defp get_user(user_id) do
    case Accounts.get_user(user_id) do
      nil -> {:error, "User not found"}
      user -> {:ok, user}
    end
  end

  defp create_or_find_address(attrs) do
    case find_existing_address(attrs) do
      nil ->
        %Address{}
        |> Address.changeset(attrs)
        |> Repo.insert()

      address ->
        {:ok, address}
    end
  end

  defp find_existing_address(attrs) do
    # Look for existing address with same details
    Repo.get_by(Address, %{
      street: attrs.street,
      city: attrs.city,
      zip_code: attrs.zip_code
    })
  end

  defp insert_trip(user, starting_point, arrival_address, price) do
    trip_attrs = %{
      user_id: user.id,
      starting_point_id: starting_point.id,
      arrival_address_id: arrival_address.id,
      price: price
    }

    %Trip{}
    |> Trip.changeset(trip_attrs)
    |> Repo.insert()
  end
end
