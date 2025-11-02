defmodule MyAppWeb.LocationLive.Index do
  use MyAppWeb, :live_view

  alias MyApp.Geo

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <.header>
        Listing Locations
        <:actions>
          <.button variant="primary" navigate={~p"/locations/new"}>
            <.icon name="hero-plus" /> New Location
          </.button>
        </:actions>
      </.header>

      <.table
        id="locations"
        rows={@streams.locations}
        row_click={fn {_id, location} -> JS.navigate(~p"/locations/#{location}") end}
      >
        <:col :let={{_id, location}} label="Name">{location.name}</:col>
        <:action :let={{_id, location}}>
          <div class="sr-only">
            <.link navigate={~p"/locations/#{location}"}>Show</.link>
          </div>
          <.link navigate={~p"/locations/#{location}/edit"}>Edit</.link>
        </:action>
        <:action :let={{id, location}}>
          <.link
            phx-click={JS.push("delete", value: %{id: location.id}) |> hide("##{id}")}
            data-confirm="Are you sure?"
          >
            Delete
          </.link>
        </:action>
      </.table>
    </Layouts.app>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Listing Locations")
     |> stream(:locations, list_locations())}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    location = Geo.get_location!(id)
    {:ok, _} = Geo.delete_location(location)

    {:noreply, stream_delete(socket, :locations, location)}
  end

  defp list_locations() do
    Geo.list_locations()
  end
end
