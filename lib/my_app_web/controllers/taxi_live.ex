defmodule MyAppWeb.TaxiLive do
  use MyAppWeb, :live_view
  alias MyApp.TaxiPricing

  # Called when LiveView first loads
  def mount(_params, _session, socket) do
    # Initial state setup
    {:ok,
     assign(socket,
       # User input: pickup address
       origin: "",
       # User input: destination  
       destination: "",
       # Calculated price (nil until calculated)
       price: nil,
       # Show/hide loading indicator
       loading: false,
       # Default map center (NYC)
       map_center: {40.7128, -74.0060},
       # Array of map markers
       markers: []
     )}
  end

  # Handle form submission
  def handle_event("calculate_price", %{"origin" => origin, "destination" => destination}, socket) do
    # Show loading state to user
    socket =
      assign(socket,
        loading: true,
        price: nil,
        origin: origin,
        destination: destination
      )

    # Send message to ourselves to process in background
    # This prevents blocking the LiveView process
    send(self(), {:calculate_price, origin, destination})

    {:noreply, socket}
  end

  # Handle browser geolocation request
  def handle_event("locate_me", _, socket) do
    # Ask browser for user's location via JavaScript
    {:noreply, push_event(socket, "get_location", %{})}
  end

  # Handle location result from browser
  def handle_event("location_result", %{"lat" => lat, "lng" => lng}, socket) do
    {lat, _} = Float.parse(lat)
    {lng, _} = Float.parse(lng)

    # Update map center and add marker
    socket =
      assign(socket,
        map_center: {lat, lng},
        markers: [%{lat: lat, lng: lng, type: :user}]
      )

    {:noreply, socket}
  end

  # Handle background price calculation
  def handle_info({:calculate_price, origin, destination}, socket) do
    case TaxiPricing.calculate_trip_price(origin, destination) do
      {:ok, pricing} ->
        # Success - update UI with price
        socket =
          assign(socket,
            price: pricing,
            loading: false
          )

        # Add markers to map
        socket = add_trip_markers(socket, pricing)
        {:noreply, socket}

      {:error, reason} ->
        # Error - show message and reset loading
        socket =
          socket
          |> put_flash(:error, "Could not calculate price: #{reason}")
          |> assign(loading: false)

        {:noreply, socket}
    end
  end

  # Handle real-time taxi location updates (if you have them)
  def handle_info({:taxi_location_update, taxi_id, lat, lng}, socket) do
    # Update taxi marker on map
    socket = update_taxi_marker(socket, taxi_id, lat, lng)
    {:noreply, socket}
  end

  # Private helper functions
  defp add_trip_markers(socket, %{origin: origin, destination: destination}) do
    markers = [
      %{lat: origin.latitude, lng: origin.longitude, type: :pickup, label: "Pickup"},
      %{
        lat: destination.latitude,
        lng: destination.longitude,
        type: :destination,
        label: "Destination"
      }
    ]

    assign(socket, markers: markers)
  end

  defp update_taxi_marker(socket, taxi_id, lat, lng) do
    # Update or add taxi marker
    current_markers = socket.assigns.markers

    new_markers =
      case Enum.find_index(current_markers, &(&1.id == taxi_id)) do
        nil ->
          # New taxi - add marker
          [%{id: taxi_id, lat: lat, lng: lng, type: :taxi} | current_markers]

        index ->
          # Existing taxi - update position
          List.update_at(current_markers, index, &(Map.put(&1, :lat, lat) |> Map.put(:lng, lng)))
      end

    assign(socket, markers: new_markers)
  end
end
