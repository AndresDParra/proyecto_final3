# Update the router (the generator will tell you what to add)
# Usually in lib/my_app_web/router.ex:

scope "/", MyAppWeb do
pipe_through :browser

live "/roles", RoleLive.Index, :index
live "/roles/new", RoleLive.Index, :new
live "/roles/:id/edit", RoleLive.Index, :edit
live "/roles/:id", RoleLive.Show, :show

live "/users", UserLive.Index, :index
live "/users/new", UserLive.Index, :new
live "/users/:id/edit", UserLive.Index, :edit
live "/users/:id", UserLive.Show, :show

live "/locations", LocationLive.Index, :index
live "/locations/new", LocationLive.Index, :new
live "/locations/:id/edit", LocationLive.Index, :edit
live "/locations/:id", LocationLive.Show, :show

live "/drivers", DriverLive.Index, :index
live "/drivers/new", DriverLive.Index, :new
live "/drivers/:id/edit", DriverLive.Index, :edit
live "/drivers/:id", DriverLive.Show, :show

live "/travel_requests", TravelRequestLive.Index, :index
live "/travel_requests/new", TravelRequestLive.Index, :new
live "/travel_requests/:id/edit", TravelRequestLive.Index, :edit
live "/travel_requests/:id", TravelRequestLive.Show, :show

live "/results", ResultLive.Index, :index
live "/results/new", ResultLive.Index, :new
live "/results/:id/edit", ResultLive.Index, :edit
live "/results/:id", ResultLive.Show, :show
end

# Run migrations
mix ecto.migrate

# Start server
mix phx.server
