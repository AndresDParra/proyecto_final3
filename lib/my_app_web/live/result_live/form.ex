defmodule MyAppWeb.ResultLive.Form do
  use MyAppWeb, :live_view

  alias MyApp.Ranking
  alias MyApp.Ranking.Result

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <.header>
        {@page_title}
        <:subtitle>Use this form to manage result records in your database.</:subtitle>
      </.header>

      <.form for={@form} id="result-form" phx-change="validate" phx-submit="save">
        <.input field={@form[:date_trip]} type="datetime-local" label="Date trip" />
        <.input field={@form[:passenger_points]} type="number" label="Passenger points" />
        <.input field={@form[:driver_points]} type="number" label="Driver points" />
        <.input field={@form[:origin]} type="text" label="Origin" />
        <.input field={@form[:status]} type="text" label="Status" />
        <footer>
          <.button phx-disable-with="Saving..." variant="primary">Save Result</.button>
          <.button navigate={return_path(@return_to, @result)}>Cancel</.button>
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
    result = Ranking.get_result!(id)

    socket
    |> assign(:page_title, "Edit Result")
    |> assign(:result, result)
    |> assign(:form, to_form(Ranking.change_result(result)))
  end

  defp apply_action(socket, :new, _params) do
    result = %Result{}

    socket
    |> assign(:page_title, "New Result")
    |> assign(:result, result)
    |> assign(:form, to_form(Ranking.change_result(result)))
  end

  @impl true
  def handle_event("validate", %{"result" => result_params}, socket) do
    changeset = Ranking.change_result(socket.assigns.result, result_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"result" => result_params}, socket) do
    save_result(socket, socket.assigns.live_action, result_params)
  end

  defp save_result(socket, :edit, result_params) do
    case Ranking.update_result(socket.assigns.result, result_params) do
      {:ok, result} ->
        {:noreply,
         socket
         |> put_flash(:info, "Result updated successfully")
         |> push_navigate(to: return_path(socket.assigns.return_to, result))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_result(socket, :new, result_params) do
    case Ranking.create_result(result_params) do
      {:ok, result} ->
        {:noreply,
         socket
         |> put_flash(:info, "Result created successfully")
         |> push_navigate(to: return_path(socket.assigns.return_to, result))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp return_path("index", _result), do: ~p"/results_and_ranking"
  defp return_path("show", result), do: ~p"/results_and_ranking/#{result}"
end
