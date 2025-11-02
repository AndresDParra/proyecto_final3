## lib/my_app_web/live/taxi_live.ex
# defmodule MyAppWeb.TaxiLive do
#  use MyAppWeb, :live_view
#
#  def mount(_params, _session, socket) do
#    # Subscribe to real-time updates
#    if connected?(socket) do
#      Phoenix.PubSub.subscribe(MyApp.PubSub, "trips")
#    end
#
#    {:ok, assign(socket, trips: list_trips())}
#  end
#
#  # When ANY user creates a trip, ALL connected users see it
#  def handle_info({:trip_created, trip}, socket) do
#    {:noreply, update(socket, :trips, fn trips -> [trip | trips] end)}
#  end
# end
#
## When a trip is created, broadcast to all users:
# def create_trip(attrs) do
#  case Repo.insert(changeset) do
#    {:ok, trip} ->
#      Phoenix.PubSub.broadcast(MyApp.PubSub, "trips", {:trip_created, trip})
#      {:ok, trip}
#  end
# end
