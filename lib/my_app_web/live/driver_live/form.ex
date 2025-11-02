defmodule MyAppWeb.DriverLive.Form do
  use MyAppWeb, :live_view

  alias MyApp.Auth
  alias MyApp.Auth.Driver

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <.header>
        {@page_title}
        <:subtitle>Use this form to manage driver records in your database.</:subtitle>
      </.header>

      <.form for={@form} id="driver-form" phx-change="validate" phx-submit="save">
        <.input field={@form[:vehicle_model]} type="text" label="Vehicle model" />
        <.input field={@form[:vehicle_plate]} type="text" label="Vehicle plate" />
        <footer>
          <.button phx-disable-with="Saving..." variant="primary">Save Driver</.button>
          <.button navigate={return_path(@return_to, @driver)}>Cancel</.button>
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
    driver = Auth.get_driver!(id)

    socket
    |> assign(:page_title, "Edit Driver")
    |> assign(:driver, driver)
    |> assign(:form, to_form(Auth.change_driver(driver)))
  end

  defp apply_action(socket, :new, _params) do
    driver = %Driver{}

    socket
    |> assign(:page_title, "New Driver")
    |> assign(:driver, driver)
    |> assign(:form, to_form(Auth.change_driver(driver)))
  end

  @impl true
  def handle_event("validate", %{"driver" => driver_params}, socket) do
    changeset = Auth.change_driver(socket.assigns.driver, driver_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"driver" => driver_params}, socket) do
    save_driver(socket, socket.assigns.live_action, driver_params)
  end

  defp save_driver(socket, :edit, driver_params) do
    case Auth.update_driver(socket.assigns.driver, driver_params) do
      {:ok, driver} ->
        {:noreply,
         socket
         |> put_flash(:info, "Driver updated successfully")
         |> push_navigate(to: return_path(socket.assigns.return_to, driver))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_driver(socket, :new, driver_params) do
    case Auth.create_driver(driver_params) do
      {:ok, driver} ->
        {:noreply,
         socket
         |> put_flash(:info, "Driver created successfully")
         |> push_navigate(to: return_path(socket.assigns.return_to, driver))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp return_path("index", _driver), do: ~p"/drivers"
  defp return_path("show", driver), do: ~p"/drivers/#{driver}"
end
