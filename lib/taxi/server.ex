defmodule Taxi.Server do
  use GenServer

  # Client API
  def start_link(initial_state \\ %{}) do
    GenServer.start_link(__MODULE__, initial_state, name: __MODULE__)
  end

  def get_user(id), do: GenServer.call(__MODULE__, {:get_user, id})
  def create_user(user), do: GenServer.call(__MODULE__, {:create_user, user})

  def create_trip_request(user, address) do
    GenServer.call(__MODULE__, {:create_trip_request, user, address})
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

  def handle_call({:create_trip_request, user, address}, _from, state) do
    now = NaiveDateTime.utc_now()

    price = calculate_total(user.address, address)

    trip = %{
      user: user,
      address: address,
      time: now,
      price: price,
      status: "pending"
    }

    # Update state with new trip
    new_state = Map.update(state, :trips, [trip], fn trips -> [trip | trips] end)
    {:reply, {:ok, trip}, new_state}
  end

  def handle_cast({:update_status, status}, state) do
    new_state = %{state | status: status}
    {:noreply, new_state}
  end

  # Private helper functions
  defp find_user_in_database(_id) do
    # TODO: Implement database lookup
    nil
  end

  defp save_user_to_database(_user_data) do
    # TODO: Implement database save
    %{id: 1, name: "User", address: "123 Main St"}
  end

  defp calculate_total(user_address, address) do
    distance = calculate_distance(user_address, address)
    # $15 per km (adjust as needed)
    total = distance * 1500
    # Round to 2 decimal places
    Float.round(total, 2)
  end

  defp calculate_distance(user_address, final_address) do
    MyApp.TaxiPricing.calculate_trip_price(user_address, final_address) 
  end
end


