defmodule MyAppWeb.UserViewController do
  use MyAppWeb, :controller

  def index(conn, _params) do
    MyApp.Auth.list_users()
    render(conn, :index)
  end

  def show(conn, %{"id" => id}) do
    # id = String.to_integer(id)
    case Mytest.get_user(id) do
      nil ->
        conn
        |> json(%{error: "User not found"})
        |> redirect(to: ~p"/Users/")

      user ->
        conn
        |> json(%{
          user: %{
            id: user.id,
            username: user.username,
            name: user.name,
            password: user.password
          }
        })
    end
  end
end
