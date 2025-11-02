defmodule MyAppWeb.LocationLive.Show do
  use MyAppWeb, :live_view

  alias MyApp.Geo

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <.header>
        Location {@location.id}
        <:subtitle>This is a location record from your database.</:subtitle>
        <:actions>
          <.button navigate={~p"/locations"}>
            <.icon name="hero-arrow-left" />
          </.button>
          <.button variant="primary" navigate={~p"/locations/#{@location}/edit?return_to=show"}>
            <.icon name="hero-pencil-square" /> Edit location
          </.button>
        </:actions>
      </.header>

      <.list>
        <:item title="Name">{@location.name}</:item>
      </.list>
    </Layouts.app>
    """
  end

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Show Location")
     |> assign(:location, Geo.get_location!(id))}
  end
end
