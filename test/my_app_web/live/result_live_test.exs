defmodule MyAppWeb.ResultLiveTest do
  use MyAppWeb.ConnCase

  import Phoenix.LiveViewTest
  import MyApp.RankingFixtures

  @create_attrs %{status: "some status", origin: "some origin", date_trip: "2025-11-01T18:59:00", passenger_points: 42, driver_points: 42}
  @update_attrs %{status: "some updated status", origin: "some updated origin", date_trip: "2025-11-02T18:59:00", passenger_points: 43, driver_points: 43}
  @invalid_attrs %{status: nil, origin: nil, date_trip: nil, passenger_points: nil, driver_points: nil}
  defp create_result(_) do
    result = result_fixture()

    %{result: result}
  end

  describe "Index" do
    setup [:create_result]

    test "lists all results_and_ranking", %{conn: conn, result: result} do
      {:ok, _index_live, html} = live(conn, ~p"/results_and_ranking")

      assert html =~ "Listing Results and ranking"
      assert html =~ result.origin
    end

    test "saves new result", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/results_and_ranking")

      assert {:ok, form_live, _} =
               index_live
               |> element("a", "New Result")
               |> render_click()
               |> follow_redirect(conn, ~p"/results_and_ranking/new")

      assert render(form_live) =~ "New Result"

      assert form_live
             |> form("#result-form", result: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#result-form", result: @create_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/results_and_ranking")

      html = render(index_live)
      assert html =~ "Result created successfully"
      assert html =~ "some origin"
    end

    test "updates result in listing", %{conn: conn, result: result} do
      {:ok, index_live, _html} = live(conn, ~p"/results_and_ranking")

      assert {:ok, form_live, _html} =
               index_live
               |> element("#results_and_ranking-#{result.id} a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/results_and_ranking/#{result}/edit")

      assert render(form_live) =~ "Edit Result"

      assert form_live
             |> form("#result-form", result: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#result-form", result: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/results_and_ranking")

      html = render(index_live)
      assert html =~ "Result updated successfully"
      assert html =~ "some updated origin"
    end

    test "deletes result in listing", %{conn: conn, result: result} do
      {:ok, index_live, _html} = live(conn, ~p"/results_and_ranking")

      assert index_live |> element("#results_and_ranking-#{result.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#results_and_ranking-#{result.id}")
    end
  end

  describe "Show" do
    setup [:create_result]

    test "displays result", %{conn: conn, result: result} do
      {:ok, _show_live, html} = live(conn, ~p"/results_and_ranking/#{result}")

      assert html =~ "Show Result"
      assert html =~ result.origin
    end

    test "updates result and returns to show", %{conn: conn, result: result} do
      {:ok, show_live, _html} = live(conn, ~p"/results_and_ranking/#{result}")

      assert {:ok, form_live, _} =
               show_live
               |> element("a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/results_and_ranking/#{result}/edit?return_to=show")

      assert render(form_live) =~ "Edit Result"

      assert form_live
             |> form("#result-form", result: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, show_live, _html} =
               form_live
               |> form("#result-form", result: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/results_and_ranking/#{result}")

      html = render(show_live)
      assert html =~ "Result updated successfully"
      assert html =~ "some updated origin"
    end
  end
end
