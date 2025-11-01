defmodule MyApp.Server do
  use GenServer

  # Client API
  def start_link(initial_state \\ %{}) do
    GenServer.start_link(__MODULE__, initial_state, name: __MODULE__)
  end

  def get_user(id), do: GenServer.call(__MODULE__, {:get_user, id})

  def create_user(user_data), do: GenServer.call(__MODULE__, {:create_user, user_data})

  def create_trip_request(user_id, destination_address) do
    GenServer.call(__MODULE__, {:create_trip_request, user_id, destination_address})
  end

  # Server Callbacks
  def init(initial_state) do
    {:ok, initial_state}
  end

  def handle_call({:get_user, id}, _from, state) do
    user = find_user_in_database(id)
    {:reply, user, state}
  end

  def handle_call({:create_user, user_data}, _from, state) do
    user = save_user_to_database(user_data)
    {:reply, {:ok, user}, state}
  end

  def handle_call({:create_trip_request, user_id, destination_address}, _from, state) do
    case find_user_in_database(user_id) do
      nil ->
        {:reply, {:error, :user_not_found}, state}

      user ->
        now = NaiveDateTime.utc_now()

        # Calculate trip price using your TaxiPricing module
        case MyApp.TaxiPricing.calculate_trip_price(user.address, destination_address) do
          {:ok, %{price: price, distance_km: distance}} ->
            trip = %{
              user_id: user_id,
              origin: user.address,
              destination: destination_address,
              time: now,
              price: price,
              distance: distance,
              active: true
            }

            # Update state with new trip
            new_state = Map.update(state, :trips, [trip], fn trips -> [trip | trips] end)
            {:reply, {:ok, trip}, new_state}

          {:error, reason} ->
            {:reply, {:error, reason}, state}
        end
    end
  end

  def handle_cast({:update_status, status}, state) do
    new_state = %{state | status: status}
    {:noreply, new_state}
  end

  # Private helper functions
  defp find_user_in_database(id) do
    # Use your actual Repo
    MyApp.Repo.get(MyApp.User, id)
  end

  defp save_user_to_database(user_data) do
    # Use your actual Repo and changeset
    %Taxi.User{}
    |> Taxi.User.changeset(user_data)
    |> MyApp.Repo.insert!()
  end
end
