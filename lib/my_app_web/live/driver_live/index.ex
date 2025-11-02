defmodule MyAppWeb.DriverLive.Index do
  use MyAppWeb, :live_view

  alias MyApp.Auth

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <.header>
        Listing Drivers
        <:actions>
          <.button variant="primary" navigate={~p"/drivers/new"}>
            <.icon name="hero-plus" /> New Driver
          </.button>
        </:actions>
      </.header>

      <.table
        id="drivers"
        rows={@streams.drivers}
        row_click={fn {_id, driver} -> JS.navigate(~p"/drivers/#{driver}") end}
      >
        <:col :let={{_id, driver}} label="Vehicle model">{driver.vehicle_model}</:col>
        <:col :let={{_id, driver}} label="Vehicle plate">{driver.vehicle_plate}</:col>
        <:action :let={{_id, driver}}>
          <div class="sr-only">
            <.link navigate={~p"/drivers/#{driver}"}>Show</.link>
          </div>
          <.link navigate={~p"/drivers/#{driver}/edit"}>Edit</.link>
        </:action>
        <:action :let={{id, driver}}>
          <.link
            phx-click={JS.push("delete", value: %{id: driver.id}) |> hide("##{id}")}
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
     |> assign(:page_title, "Listing Drivers")
     |> stream(:drivers, list_drivers())}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    driver = Auth.get_driver!(id)
    {:ok, _} = Auth.delete_driver(driver)

    {:noreply, stream_delete(socket, :drivers, driver)}
  end

  defp list_drivers() do
    Auth.list_drivers()
  end
end
