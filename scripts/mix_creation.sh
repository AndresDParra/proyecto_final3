# 1. Create roles first (no dependencies)
mix phx.gen.live Auth Role roles name:string

# 2. Create users (depends on roles)
mix phx.gen.live Auth User users role_id:references:roles name:string username:string password:string

# 3. Create locations (no dependencies)
mix phx.gen.live Geo Location locations name:string

# 4. Create drivers (depends on users)
mix phx.gen.live Auth Driver drivers vehicle_model:string vehicle_plate:string

# 5. Create travel requests (depends on users and locations)
mix phx.gen.live Taxi TravelRequest travel_requests \
  passenger_id:references:users \
  driver_id:references:users \
  origin_location_id:references:locations \
  destination_location_id:references:locations \
  status:string

# 6. Create results/ranking (depends on users)
mix phx.gen.live Ranking Result results_and_ranking \
  date_trip:datetime \
  passenger_id:references:users \
  passenger_points:integer \
  driver_id:references:users \
  driver_points:integer \
  origin:string \
  status:string
