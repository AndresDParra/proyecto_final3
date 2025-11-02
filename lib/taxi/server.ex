# defmodule MyApp.Server do
#  use GenServer
#
#  # Client API
#  def start_link(initial_state \\ %{}) do
#    GenServer.start_link(__MODULE__, initial_state, name: __MODULE__)
#  end
#
#  def get_user(id), do: GenServer.call(__MODULE__, {:get_user, id})
#  def create_user(user_data), do: GenServer.call(__MODULE__, {:create_user, user_data})
#
#  def create_trip_request(user_id, destination_address) do
#    GenServer.call(__MODULE__, {:create_trip_request, user_id, destination_address})
#  end
#
#  # Server Callbacks
#  def init(initial_state) do
#    {:ok, initial_state}
#  end
#
#  def handle_call({:get_user, id}, _from, state) do
#    user = find_user_in_database(id)
#    {:reply, user, state}
#  end
#
#  def handle_call({:create_user, user_data}, _from, state) do
#    case save_user_to_database(user_data) do
#      {:ok, user} ->
#        {:reply, {:ok, user}, state}
#
#      {:error, changeset} ->
#        {:reply, {:error, changeset}, state}
#    end
#  end
#
#  def handle_call({:create_trip_request, user_id, destination_address}, _from, state) do
#    case find_user_in_database(user_id) do
#      nil ->
#        {:reply, {:error, :user_not_found}, state}
#
#      user ->
#        # Your trip request logic here
#        {:reply, {:ok, "Trip created for user #{user_id}"}, state}
#    end
#  end
#
#  def handle_cast({:update_status, status}, state) do
#    new_state = %{state | status: status}
#    {:noreply, new_state}
#  end
#
#  # Private helper functions using Ecto
#  defp find_user_in_database(id) do
#    MyApp.Repo.get(MyApp.User, id)
#  end
#
#  defp save_user_to_database(user_data) do
#    %MyApp.User{}
#    |> MyApp.User.changeset(user_data)
#    |> MyApp.Repo.insert()
#  end
# end
#

