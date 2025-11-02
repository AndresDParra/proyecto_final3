defmodule MyAppWeb.RoleLive.Show do
  use MyAppWeb, :live_view

  alias MyApp.Auth

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <.header>
        Role {@role.id}
        <:subtitle>This is a role record from your database.</:subtitle>
        <:actions>
          <.button navigate={~p"/roles"}>
            <.icon name="hero-arrow-left" />
          </.button>
          <.button variant="primary" navigate={~p"/roles/#{@role}/edit?return_to=show"}>
            <.icon name="hero-pencil-square" /> Edit role
          </.button>
        </:actions>
      </.header>

      <.list>
        <:item title="Name">{@role.name}</:item>
      </.list>
    </Layouts.app>
    """
  end

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Show Role")
     |> assign(:role, Auth.get_role!(id))}
  end
end
