defmodule MyAppWeb.TextController do
  use MyAppWeb, :controller

  def view(conn, _params) do
    # Simple response to test
    text(conn, "Header endpoint working!")

    # Or for HTML:
    # render(conn, :view)
  end
end
