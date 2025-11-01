defmodule MyApp.OSMDistance do
  @moduledoc """
  Calculates distances between addresses in Armenia, Quindío, Colombia
  using OpenStreetMap APIs
  """

  @earth_radius_km 6371.0
  @nominatim_url "https://nominatim.openstreetmap.org"
  @osrm_url "https://router.project-osrm.org"

  # Bounding box for Armenia, Quindío (approximate)
  # Format: min_lon, min_lat, max_lon, max_lat
  @armenia_bbox "-75.75,4.48,-75.63,4.60"
  @default_location "Armenia, Quindío, Colombia"

  @doc """
  Calculate straight-line distance (Haversine)
  """
  def calculate_straight_line_distance(origin, destination) do
    with {:ok, origin_coords} <- geocode_address(origin),
         {:ok, dest_coords} <- geocode_address(destination) do
      distance = haversine_distance(origin_coords, dest_coords)
      {:ok, %{distance_km: distance}}
    end
  end

  @doc """
  Calculate actual driving distance using OSRM routing
  """
  def calculate_driving_distance(origin, destination) do
    with {:ok, {lat1, lon1}} <- geocode_address(origin),
         {:ok, {lat2, lon2}} <- geocode_address(destination) do
      # OSRM uses lon,lat order (not lat,lon!)
      url = "#{@osrm_url}/route/v1/driving/#{lon1},#{lat1};#{lon2},#{lat2}"

      case Req.get(url,
             params: [overview: "false", alternatives: "false"],
             headers: [{"user-agent", "MyApp-Taxi/1.0"}]
           ) do
        {:ok, %Req.Response{status: 200, body: %{"routes" => [route | _]}}} ->
          distance_km = route["distance"] / 1000
          duration_min = route["duration"] / 60

          {:ok,
           %{
             distance_km: Float.round(distance_km, 2),
             duration_minutes: Float.round(duration_min, 1),
             type: :driving
           }}

        {:ok, %Req.Response{status: status}} ->
          {:error, {:routing_error, status}}

        {:error, reason} ->
          {:error, {:network_error, reason}}
      end
    end
  end

  @doc """
  Smart distance calculation with fallback
  """
  def calculate_distance_with_fallback(origin, destination) do
    case calculate_driving_distance(origin, destination) do
      {:ok, result} ->
        {:ok, result}

      {:error, _reason} ->
        # Fallback to straight-line with 35% buffer
        case calculate_straight_line_distance(origin, destination) do
          {:ok, %{distance_km: distance}} ->
            estimated = distance * 1.35

            {:ok,
             %{
               distance_km: Float.round(estimated, 2),
               duration_minutes: Float.round(estimated * 3, 1),
               type: :estimated
             }}

          error ->
            error
        end
    end
  end

  defp geocode_address(address) when is_binary(address) do
    # Enhance address with location if not already included
    search_query =
      if String.contains?(String.downcase(address), "armenia") do
        address
      else
        "#{address}, #{@default_location}"
      end

    url = "#{@nominatim_url}/search"

    params = [
      q: search_query,
      format: "json",
      limit: 1,
      # Strict bounding
      bounded: 1,
      # Focus area
      viewbox: @armenia_bbox,
      # Colombia only
      countrycodes: "co"
    ]

    case Req.get(url,
           params: params,
           headers: [{"user-agent", "MyApp-Taxi/1.0"}]
         ) do
      {:ok, %Req.Response{status: 200, body: [result | _]}} ->
        parse_geocode_result(result)

      {:ok, %Req.Response{status: 200, body: []}} ->
        # Try without bounding box as fallback
        geocode_address_fallback(search_query)

      {:ok, %Req.Response{status: status}} ->
        {:error, {:http_error, status}}

      {:error, reason} ->
        {:error, {:network_error, reason}}
    end
  end

  defp geocode_address_fallback(address) do
    url = "#{@nominatim_url}/search"

    case Req.get(url,
           params: [q: address, format: "json", limit: 1, countrycodes: "co"],
           headers: [{"user-agent", "MyApp-Taxi/1.0"}]
         ) do
      {:ok, %Req.Response{status: 200, body: [result | _]}} ->
        parse_geocode_result(result)

      {:ok, %Req.Response{status: 200, body: []}} ->
        {:error, :address_not_found}

      _ ->
        {:error, :geocoding_failed}
    end
  end

  defp parse_geocode_result(%{"lat" => lat, "lon" => lon}) do
    {:ok, {String.to_float(lat), String.to_float(lon)}}
  end

  defp parse_geocode_result(_), do: {:error, :invalid_response}

  defp haversine_distance({lat1, lon1}, {lat2, lon2}) do
    lat1_rad = degrees_to_radians(lat1)
    lat2_rad = degrees_to_radians(lat2)
    lon1_rad = degrees_to_radians(lon1)
    lon2_rad = degrees_to_radians(lon2)

    dlat = lat2_rad - lat1_rad
    dlon = lon2_rad - lon1_rad

    a =
      :math.pow(:math.sin(dlat / 2), 2) +
        :math.cos(lat1_rad) * :math.cos(lat2_rad) *
          :math.pow(:math.sin(dlon / 2), 2)

    c = 2 * :math.atan2(:math.sqrt(a), :math.sqrt(1 - a))

    @earth_radius_km * c
  end

  defp degrees_to_radians(degrees) do
    degrees * :math.pi() / 180
  end
end
