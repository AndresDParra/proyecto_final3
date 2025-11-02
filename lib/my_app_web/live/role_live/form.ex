defmodule MyAppWeb.RoleLive.Form do
  use MyAppWeb, :live_view

  alias MyApp.Auth
  alias MyApp.Auth.Role

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <.header>
        {@page_title}
        <:subtitle>Use this form to manage role records in your database.</:subtitle>
      </.header>

      <.form for={@form} id="role-form" phx-change="validate" phx-submit="save">
        <.input field={@form[:name]} type="text" label="Name" />
        <footer>
          <.button phx-disable-with="Saving..." variant="primary">Save Role</.button>
          <.button navigate={return_path(@return_to, @role)}>Cancel</.button>
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
    role = Auth.get_role!(id)

    socket
    |> assign(:page_title, "Edit Role")
    |> assign(:role, role)
    |> assign(:form, to_form(Auth.change_role(role)))
  end

  defp apply_action(socket, :new, _params) do
    role = %Role{}

    socket
    |> assign(:page_title, "New Role")
    |> assign(:role, role)
    |> assign(:form, to_form(Auth.change_role(role)))
  end

  @impl true
  def handle_event("validate", %{"role" => role_params}, socket) do
    changeset = Auth.change_role(socket.assigns.role, role_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"role" => role_params}, socket) do
    save_role(socket, socket.assigns.live_action, role_params)
  end

  defp save_role(socket, :edit, role_params) do
    case Auth.update_role(socket.assigns.role, role_params) do
      {:ok, role} ->
        {:noreply,
         socket
         |> put_flash(:info, "Role updated successfully")
         |> push_navigate(to: return_path(socket.assigns.return_to, role))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_role(socket, :new, role_params) do
    case Auth.create_role(role_params) do
      {:ok, role} ->
        {:noreply,
         socket
         |> put_flash(:info, "Role created successfully")
         |> push_navigate(to: return_path(socket.assigns.return_to, role))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp return_path("index", _role), do: ~p"/roles"
  defp return_path("show", role), do: ~p"/roles/#{role}"
end
