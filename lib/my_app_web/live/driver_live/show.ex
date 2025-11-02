defmodule MyAppWeb.DriverLive.Show do
  use MyAppWeb, :live_view

  alias MyApp.Auth

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <.header>
        Driver {@driver.id}
        <:subtitle>This is a driver record from your database.</:subtitle>
        <:actions>
          <.button navigate={~p"/drivers"}>
            <.icon name="hero-arrow-left" />
          </.button>
          <.button variant="primary" navigate={~p"/drivers/#{@driver}/edit?return_to=show"}>
            <.icon name="hero-pencil-square" /> Edit driver
          </.button>
        </:actions>
      </.header>

      <.list>
        <:item title="Vehicle model">{@driver.vehicle_model}</:item>
        <:item title="Vehicle plate">{@driver.vehicle_plate}</:item>
      </.list>
    </Layouts.app>
    """
  end

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Show Driver")
     |> assign(:driver, Auth.get_driver!(id))}
  end
end
