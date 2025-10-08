defmodule MyAppWeb.TaxiController do
  use MyAppWeb, :controller

  def index(conn, _params) do
    render(conn, :index)
  end
end
