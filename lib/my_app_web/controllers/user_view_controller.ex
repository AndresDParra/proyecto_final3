defmodule MyAppWeb.UserViewController do
  use MyAppWeb, :controller

  def index(conn, _params) do
    users = MyApp.Auth.list_users()

    conn
    |> json(%{
      users:
        Enum.map(users, fn user ->
          %{
            id: user.id,
            username: user.username,
            name: user.name
            # Don't include password in JSON response!
          }
        end)
    })
  end

  def show(conn, %{"id" => id}) do
    # Will show 404 page if not found
    user = MyApp.Auth.get_user!(id)

    json(conn, %{
      user: %{
        id: user.id,
        username: user.username,
        name: user.name
      }
    })
  end
end
