# defmodule MyApp.OSMDistance do
#  @moduledoc """
#  Calculates distances between addresses using OpenStreetMap Nominatim API
#  """
#
#  @earth_radius_km 6371.0
#  @nominatim_url "https://nominatim.openstreetmap.org"
#
#  def calculate_straight_line_distance(origin, destination) do
#    with {:ok, origin_coords} <- geocode_address(origin),
#         {:ok, dest_coords} <- geocode_address(destination) do
#      distance = haversine_distance(origin_coords, dest_coords)
#      {:ok, %{distance_km: distance}}
#    else
#      {:error, reason} -> {:error, reason}
#    end
#  end
#
#  defp geocode_address(address) when is_binary(address) do
#    url = "#{@nominatim_url}/search"
#
#    case Req.get(url,
#           params: [q: address, format: "json", limit: 1],
#           headers: [{"user-agent", "MyApp-Taxi/1.0"}]
#         ) do
#      {:ok, %Req.Response{status: 200, body: [%{"lat" => lat, "lon" => lon} | _]}} ->
#        {:ok, {String.to_float(lat), String.to_float(lon)}}
#
#      {:ok, %Req.Response{status: 200, body: []}} ->
#        {:error, :address_not_found}
#
#      {:ok, %Req.Response{status: status}} ->
#        {:error, {:http_error, status}}
#
#      {:error, reason} ->
#        {:error, {:network_error, reason}}
#    end
#  end
#
#  defp haversine_distance({lat1, lon1}, {lat2, lon2}) do
#    # Convert degrees to radians
#    lat1_rad = degrees_to_radians(lat1)
#    lat2_rad = degrees_to_radians(lat2)
#    lon1_rad = degrees_to_radians(lon1)
#    lon2_rad = degrees_to_radians(lon2)
#
#    # Haversine formula
#    dlat = lat2_rad - lat1_rad
#    dlon = lon2_rad - lon1_rad
#
#    a =
#      :math.pow(:math.sin(dlat / 2), 2) +
#        :math.cos(lat1_rad) * :math.cos(lat2_rad) *
#          :math.pow(:math.sin(dlon / 2), 2)
#
#    c = 2 * :math.atan2(:math.sqrt(a), :math.sqrt(1 - a))
#
#    @earth_radius_km * c
#  end
#
#  defp degrees_to_radians(degrees) do
#    degrees * :math.pi() / 180
#  end
# end
#

