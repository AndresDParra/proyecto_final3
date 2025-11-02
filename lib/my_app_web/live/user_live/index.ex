defmodule MyAppWeb.UserLive.Index do
  use MyAppWeb, :live_view

  alias MyApp.Auth

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <.header>
        Listing Users
        <:actions>
          <.button variant="primary" navigate={~p"/users/new"}>
            <.icon name="hero-plus" /> New User
          </.button>
        </:actions>
      </.header>

      <.table
        id="users"
        rows={@streams.users}
        row_click={fn {_id, user} -> JS.navigate(~p"/users/#{user}") end}
      >
        <:col :let={{_id, user}} label="Name">{user.name}</:col>
        <:col :let={{_id, user}} label="Username">{user.username}</:col>
        <:col :let={{_id, user}} label="Password">{user.password}</:col>
        <:action :let={{_id, user}}>
          <div class="sr-only">
            <.link navigate={~p"/users/#{user}"}>Show</.link>
          </div>
          <.link navigate={~p"/users/#{user}/edit"}>Edit</.link>
        </:action>
        <:action :let={{id, user}}>
          <.link
            phx-click={JS.push("delete", value: %{id: user.id}) |> hide("##{id}")}
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
     |> assign(:page_title, "Listing Users")
     |> stream(:users, list_users())}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    user = Auth.get_user!(id)
    {:ok, _} = Auth.delete_user(user)

    {:noreply, stream_delete(socket, :users, user)}
  end

  defp list_users() do
    Auth.list_users()
  end
end
