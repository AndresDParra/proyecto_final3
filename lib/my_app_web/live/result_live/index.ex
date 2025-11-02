defmodule MyAppWeb.ResultLive.Index do
  use MyAppWeb, :live_view

  alias MyApp.Ranking

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <.header>
        Listing Results and ranking
        <:actions>
          <.button variant="primary" navigate={~p"/results_and_ranking/new"}>
            <.icon name="hero-plus" /> New Result
          </.button>
        </:actions>
      </.header>

      <.table
        id="results_and_ranking"
        rows={@streams.results_and_ranking}
        row_click={fn {_id, result} -> JS.navigate(~p"/results_and_ranking/#{result}") end}
      >
        <:col :let={{_id, result}} label="Date trip">{result.date_trip}</:col>
        <:col :let={{_id, result}} label="Passenger points">{result.passenger_points}</:col>
        <:col :let={{_id, result}} label="Driver points">{result.driver_points}</:col>
        <:col :let={{_id, result}} label="Origin">{result.origin}</:col>
        <:col :let={{_id, result}} label="Status">{result.status}</:col>
        <:action :let={{_id, result}}>
          <div class="sr-only">
            <.link navigate={~p"/results_and_ranking/#{result}"}>Show</.link>
          </div>
          <.link navigate={~p"/results_and_ranking/#{result}/edit"}>Edit</.link>
        </:action>
        <:action :let={{id, result}}>
          <.link
            phx-click={JS.push("delete", value: %{id: result.id}) |> hide("##{id}")}
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
     |> assign(:page_title, "Listing Results and ranking")
     |> stream(:results_and_ranking, list_results_and_ranking())}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    result = Ranking.get_result!(id)
    {:ok, _} = Ranking.delete_result(result)

    {:noreply, stream_delete(socket, :results_and_ranking, result)}
  end

  defp list_results_and_ranking() do
    Ranking.list_results_and_ranking()
  end
end
