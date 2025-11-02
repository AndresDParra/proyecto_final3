defmodule MyAppWeb.TravelRequestLive.Index do
  use MyAppWeb, :live_view

  alias MyApp.Taxi

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <.header>
        Listing Travel requests
        <:actions>
          <.button variant="primary" navigate={~p"/travel_requests/new"}>
            <.icon name="hero-plus" /> New Travel request
          </.button>
        </:actions>
      </.header>

      <.table
        id="travel_requests"
        rows={@streams.travel_requests}
        row_click={fn {_id, travel_request} -> JS.navigate(~p"/travel_requests/#{travel_request}") end}
      >
        <:col :let={{_id, travel_request}} label="Status">{travel_request.status}</:col>
        <:action :let={{_id, travel_request}}>
          <div class="sr-only">
            <.link navigate={~p"/travel_requests/#{travel_request}"}>Show</.link>
          </div>
          <.link navigate={~p"/travel_requests/#{travel_request}/edit"}>Edit</.link>
        </:action>
        <:action :let={{id, travel_request}}>
          <.link
            phx-click={JS.push("delete", value: %{id: travel_request.id}) |> hide("##{id}")}
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
     |> assign(:page_title, "Listing Travel requests")
     |> stream(:travel_requests, list_travel_requests())}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    travel_request = Taxi.get_travel_request!(id)
    {:ok, _} = Taxi.delete_travel_request(travel_request)

    {:noreply, stream_delete(socket, :travel_requests, travel_request)}
  end

  defp list_travel_requests() do
    Taxi.list_travel_requests()
  end
end
