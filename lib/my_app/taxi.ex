defmodule MyApp.Taxi do
  @moduledoc """
  The Taxi context.
  """

  import Ecto.Query, warn: false
  alias MyApp.Repo

  alias MyApp.Taxi.TravelRequest

  @doc """
  Returns the list of travel_requests.

  ## Examples

      iex> list_travel_requests()
      [%TravelRequest{}, ...]

  """
  def list_travel_requests do
    Repo.all(TravelRequest)
  end

  @doc """
  Gets a single travel_request.

  Raises `Ecto.NoResultsError` if the Travel request does not exist.

  ## Examples

      iex> get_travel_request!(123)
      %TravelRequest{}

      iex> get_travel_request!(456)
      ** (Ecto.NoResultsError)

  """
  def get_travel_request!(id), do: Repo.get!(TravelRequest, id)

  @doc """
  Creates a travel_request.

  ## Examples

      iex> create_travel_request(%{field: value})
      {:ok, %TravelRequest{}}

      iex> create_travel_request(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_travel_request(attrs) do
    %TravelRequest{}
    |> TravelRequest.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a travel_request.

  ## Examples

      iex> update_travel_request(travel_request, %{field: new_value})
      {:ok, %TravelRequest{}}

      iex> update_travel_request(travel_request, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_travel_request(%TravelRequest{} = travel_request, attrs) do
    travel_request
    |> TravelRequest.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a travel_request.

  ## Examples

      iex> delete_travel_request(travel_request)
      {:ok, %TravelRequest{}}

      iex> delete_travel_request(travel_request)
      {:error, %Ecto.Changeset{}}

  """
  def delete_travel_request(%TravelRequest{} = travel_request) do
    Repo.delete(travel_request)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking travel_request changes.

  ## Examples

      iex> change_travel_request(travel_request)
      %Ecto.Changeset{data: %TravelRequest{}}

  """
  def change_travel_request(%TravelRequest{} = travel_request, attrs \\ %{}) do
    TravelRequest.changeset(travel_request, attrs)
  end
end
