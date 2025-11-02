defmodule MyAppWeb.TravelRequestLive.Show do
  use MyAppWeb, :live_view

  alias MyApp.Taxi

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <.header>
        Travel request {@travel_request.id}
        <:subtitle>This is a travel_request record from your database.</:subtitle>
        <:actions>
          <.button navigate={~p"/travel_requests"}>
            <.icon name="hero-arrow-left" />
          </.button>
          <.button variant="primary" navigate={~p"/travel_requests/#{@travel_request}/edit?return_to=show"}>
            <.icon name="hero-pencil-square" /> Edit travel_request
          </.button>
        </:actions>
      </.header>

      <.list>
        <:item title="Status">{@travel_request.status}</:item>
      </.list>
    </Layouts.app>
    """
  end

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Show Travel request")
     |> assign(:travel_request, Taxi.get_travel_request!(id))}
  end
end
