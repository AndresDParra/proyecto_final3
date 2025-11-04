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

  def show(conn, %{"id" => id_param}) do
    case Integer.parse(id_param) do
      {id, ""} ->
        case safe_get_user(id) do
          {:ok, user} ->
            conn
            |> json(%{
              data: [
                %{
                  type: "user",
                  id: to_string(user.id),
                  attributes: %{
                    role_id: user.role_id,
                    name: user.name,
                    username: user.username
                  }
                }
              ]
            })

          {:error, :not_found} ->
            conn
            |> put_status(:not_found)
            |> json(%{error: "User not found"})

          {:error, reason} ->
            conn
            |> put_status(:internal_server_error)
            |> json(%{error: "Error retrieving user: #{reason}"})
        end

      _ ->
        conn
        |> put_status(:bad_request)
        |> json(%{error: "Invalid ID format"})
    end
  end

  defp safe_get_user(id) do
    try do
      case Mytest.get_user(id) do
        nil -> {:error, :not_found}
        user -> {:ok, user}
      end
    rescue
      e in Ecto.Query.CastError ->
        {:error, "Invalid ID type: #{Exception.message(e)}"}

      e ->
        {:error, Exception.message(e)}
    end
  end
end
