defmodule MyApp.TaxiPricing do
  alias MyApp.OSMDistance

  @base_fare 3.00
  @per_km_rate 1.50
  @minimum_fare 5.00

  def calculate_trip_price(origin, destination) do
    case OSMDistance.calculate_straight_line_distance(origin, destination) do
      {:ok, %{distance_km: distance}} ->
        # Add 25% buffer for actual driving distance vs straight-line
        estimated_driving_distance = distance * 1.25

        price = @base_fare + estimated_driving_distance * @per_km_rate
        final_price = max(price, @minimum_fare)

        {:ok,
         %{
           price: Float.round(final_price, 2),
           estimated_distance_km: Float.round(estimated_driving_distance, 2),
           straight_line_distance_km: Float.round(distance, 2),
           note: "Price based on straight-line distance with 25% buffer for actual route"
         }}

      {:error, _reason} ->
        # Fallback to zone-based pricing
        calculate_zone_price(origin, destination)
    end
  end

  defp calculate_zone_price(origin, destination) do
    # Simple zone-based pricing when geocoding fails
    zones = %{
      "downtown" => 8.00,
      "suburbs" => 15.00,
      "airport" => 25.00,
      "portal_quindio" => 15.00,
      "unicentro" => 5.00,
      "default" => 12.00
    }

    # Simple logic to guess zone from address
    origin_zone = guess_zone(origin)
    dest_zone = guess_zone(destination)

    base_price = if origin_zone == dest_zone, do: zones[origin_zone], else: zones["default"]

    {:ok,
     %{
       price: base_price,
       note: "Zone-based pricing (geocoding unavailable)"
     }}
  end

  defp guess_zone(address) do
    cond do
      String.contains?(address, "airport") -> "airport"
      String.contains?(address, ["downtown", "center", "central"]) -> "downtown"
      String.contains?(address, ["suburb", "outskirts"]) -> "suburbs"
      true -> "default"
    end
  end
end

