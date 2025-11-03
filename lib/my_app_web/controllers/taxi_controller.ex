defmodule MyAppWeb.TaxiController do
  use MyAppWeb, :controller

  def index(conn, _params) do
    render(conn, :index)
  end

  def show(conn, %{"id" => id}) do
    case Mytest.get_user(id) do
      nil ->
        conn
        |> put_flash(:error, "error user not found")
        |> redirect(to: ~p"/Users/")

      user ->
        render(conn, :show, user: user)
    end
  end

  def edit(conn, %{"id" => id}) do
    user = Mytest.get_user(id)
    changeset = MyApp.Auth.change_user(user)
    render(conn, :edit, user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Mytest.get_user(id)

    case MyApp.Auth.update_user(user, user_params) do
      {:ok, user} ->
        conn |> put_flash(:info, "User updated correctly") |> redirect(~p"/Users/#{user}")

      {:error, changeset} ->
        render(conn, :edit, user: user, changeset: changeset)
    end
  end

  def new(conn, _params) do
    changeset = MyApp.Auth.change_user(%{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case MyApp.Auth.create_user(user_params) do
      {:ok, user} ->
        conn |> put_flash(:info, "User created correctly") |> redirect(~p"/Users/#{user}")

      {:error, changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end
end
