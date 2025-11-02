defmodule MyAppWeb.TravelRequestLive.Form do
  use MyAppWeb, :live_view

  alias MyApp.Taxi
  alias MyApp.Taxi.TravelRequest

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <.header>
        {@page_title}
        <:subtitle>Use this form to manage travel_request records in your database.</:subtitle>
      </.header>

      <.form for={@form} id="travel_request-form" phx-change="validate" phx-submit="save">
        <.input field={@form[:status]} type="text" label="Status" />
        <footer>
          <.button phx-disable-with="Saving..." variant="primary">Save Travel request</.button>
          <.button navigate={return_path(@return_to, @travel_request)}>Cancel</.button>
        </footer>
      </.form>
    </Layouts.app>
    """
  end

  @impl true
  def mount(params, _session, socket) do
    {:ok,
     socket
     |> assign(:return_to, return_to(params["return_to"]))
     |> apply_action(socket.assigns.live_action, params)}
  end

  defp return_to("show"), do: "show"
  defp return_to(_), do: "index"

  defp apply_action(socket, :edit, %{"id" => id}) do
    travel_request = Taxi.get_travel_request!(id)

    socket
    |> assign(:page_title, "Edit Travel request")
    |> assign(:travel_request, travel_request)
    |> assign(:form, to_form(Taxi.change_travel_request(travel_request)))
  end

  defp apply_action(socket, :new, _params) do
    travel_request = %TravelRequest{}

    socket
    |> assign(:page_title, "New Travel request")
    |> assign(:travel_request, travel_request)
    |> assign(:form, to_form(Taxi.change_travel_request(travel_request)))
  end

  @impl true
  def handle_event("validate", %{"travel_request" => travel_request_params}, socket) do
    changeset = Taxi.change_travel_request(socket.assigns.travel_request, travel_request_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"travel_request" => travel_request_params}, socket) do
    save_travel_request(socket, socket.assigns.live_action, travel_request_params)
  end

  defp save_travel_request(socket, :edit, travel_request_params) do
    case Taxi.update_travel_request(socket.assigns.travel_request, travel_request_params) do
      {:ok, travel_request} ->
        {:noreply,
         socket
         |> put_flash(:info, "Travel request updated successfully")
         |> push_navigate(to: return_path(socket.assigns.return_to, travel_request))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_travel_request(socket, :new, travel_request_params) do
    case Taxi.create_travel_request(travel_request_params) do
      {:ok, travel_request} ->
        {:noreply,
         socket
         |> put_flash(:info, "Travel request created successfully")
         |> push_navigate(to: return_path(socket.assigns.return_to, travel_request))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp return_path("index", _travel_request), do: ~p"/travel_requests"
  defp return_path("show", travel_request), do: ~p"/travel_requests/#{travel_request}"
end
