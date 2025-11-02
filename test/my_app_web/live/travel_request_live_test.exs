defmodule MyAppWeb.TravelRequestLiveTest do
  use MyAppWeb.ConnCase

  import Phoenix.LiveViewTest
  import MyApp.TaxiFixtures

  @create_attrs %{status: "some status"}
  @update_attrs %{status: "some updated status"}
  @invalid_attrs %{status: nil}
  defp create_travel_request(_) do
    travel_request = travel_request_fixture()

    %{travel_request: travel_request}
  end

  describe "Index" do
    setup [:create_travel_request]

    test "lists all travel_requests", %{conn: conn, travel_request: travel_request} do
      {:ok, _index_live, html} = live(conn, ~p"/travel_requests")

      assert html =~ "Listing Travel requests"
      assert html =~ travel_request.status
    end

    test "saves new travel_request", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/travel_requests")

      assert {:ok, form_live, _} =
               index_live
               |> element("a", "New Travel request")
               |> render_click()
               |> follow_redirect(conn, ~p"/travel_requests/new")

      assert render(form_live) =~ "New Travel request"

      assert form_live
             |> form("#travel_request-form", travel_request: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#travel_request-form", travel_request: @create_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/travel_requests")

      html = render(index_live)
      assert html =~ "Travel request created successfully"
      assert html =~ "some status"
    end

    test "updates travel_request in listing", %{conn: conn, travel_request: travel_request} do
      {:ok, index_live, _html} = live(conn, ~p"/travel_requests")

      assert {:ok, form_live, _html} =
               index_live
               |> element("#travel_requests-#{travel_request.id} a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/travel_requests/#{travel_request}/edit")

      assert render(form_live) =~ "Edit Travel request"

      assert form_live
             |> form("#travel_request-form", travel_request: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#travel_request-form", travel_request: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/travel_requests")

      html = render(index_live)
      assert html =~ "Travel request updated successfully"
      assert html =~ "some updated status"
    end

    test "deletes travel_request in listing", %{conn: conn, travel_request: travel_request} do
      {:ok, index_live, _html} = live(conn, ~p"/travel_requests")

      assert index_live |> element("#travel_requests-#{travel_request.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#travel_requests-#{travel_request.id}")
    end
  end

  describe "Show" do
    setup [:create_travel_request]

    test "displays travel_request", %{conn: conn, travel_request: travel_request} do
      {:ok, _show_live, html} = live(conn, ~p"/travel_requests/#{travel_request}")

      assert html =~ "Show Travel request"
      assert html =~ travel_request.status
    end

    test "updates travel_request and returns to show", %{conn: conn, travel_request: travel_request} do
      {:ok, show_live, _html} = live(conn, ~p"/travel_requests/#{travel_request}")

      assert {:ok, form_live, _} =
               show_live
               |> element("a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/travel_requests/#{travel_request}/edit?return_to=show")

      assert render(form_live) =~ "Edit Travel request"

      assert form_live
             |> form("#travel_request-form", travel_request: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, show_live, _html} =
               form_live
               |> form("#travel_request-form", travel_request: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/travel_requests/#{travel_request}")

      html = render(show_live)
      assert html =~ "Travel request updated successfully"
      assert html =~ "some updated status"
    end
  end
end
