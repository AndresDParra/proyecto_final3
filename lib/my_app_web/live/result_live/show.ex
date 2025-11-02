defmodule MyAppWeb.ResultLive.Show do
  use MyAppWeb, :live_view

  alias MyApp.Ranking

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <.header>
        Result {@result.id}
        <:subtitle>This is a result record from your database.</:subtitle>
        <:actions>
          <.button navigate={~p"/results_and_ranking"}>
            <.icon name="hero-arrow-left" />
          </.button>
          <.button variant="primary" navigate={~p"/results_and_ranking/#{@result}/edit?return_to=show"}>
            <.icon name="hero-pencil-square" /> Edit result
          </.button>
        </:actions>
      </.header>

      <.list>
        <:item title="Date trip">{@result.date_trip}</:item>
        <:item title="Passenger points">{@result.passenger_points}</:item>
        <:item title="Driver points">{@result.driver_points}</:item>
        <:item title="Origin">{@result.origin}</:item>
        <:item title="Status">{@result.status}</:item>
      </.list>
    </Layouts.app>
    """
  end

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Show Result")
     |> assign(:result, Ranking.get_result!(id))}
  end
end
