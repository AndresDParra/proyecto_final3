defmodule MyAppWeb.DriverLiveTest do
  use MyAppWeb.ConnCase

  import Phoenix.LiveViewTest
  import MyApp.AuthFixtures

  @create_attrs %{vehicle_model: "some vehicle_model", vehicle_plate: "some vehicle_plate"}
  @update_attrs %{vehicle_model: "some updated vehicle_model", vehicle_plate: "some updated vehicle_plate"}
  @invalid_attrs %{vehicle_model: nil, vehicle_plate: nil}
  defp create_driver(_) do
    driver = driver_fixture()

    %{driver: driver}
  end

  describe "Index" do
    setup [:create_driver]

    test "lists all drivers", %{conn: conn, driver: driver} do
      {:ok, _index_live, html} = live(conn, ~p"/drivers")

      assert html =~ "Listing Drivers"
      assert html =~ driver.vehicle_model
    end

    test "saves new driver", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/drivers")

      assert {:ok, form_live, _} =
               index_live
               |> element("a", "New Driver")
               |> render_click()
               |> follow_redirect(conn, ~p"/drivers/new")

      assert render(form_live) =~ "New Driver"

      assert form_live
             |> form("#driver-form", driver: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#driver-form", driver: @create_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/drivers")

      html = render(index_live)
      assert html =~ "Driver created successfully"
      assert html =~ "some vehicle_model"
    end

    test "updates driver in listing", %{conn: conn, driver: driver} do
      {:ok, index_live, _html} = live(conn, ~p"/drivers")

      assert {:ok, form_live, _html} =
               index_live
               |> element("#drivers-#{driver.id} a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/drivers/#{driver}/edit")

      assert render(form_live) =~ "Edit Driver"

      assert form_live
             |> form("#driver-form", driver: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#driver-form", driver: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/drivers")

      html = render(index_live)
      assert html =~ "Driver updated successfully"
      assert html =~ "some updated vehicle_model"
    end

    test "deletes driver in listing", %{conn: conn, driver: driver} do
      {:ok, index_live, _html} = live(conn, ~p"/drivers")

      assert index_live |> element("#drivers-#{driver.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#drivers-#{driver.id}")
    end
  end

  describe "Show" do
    setup [:create_driver]

    test "displays driver", %{conn: conn, driver: driver} do
      {:ok, _show_live, html} = live(conn, ~p"/drivers/#{driver}")

      assert html =~ "Show Driver"
      assert html =~ driver.vehicle_model
    end

    test "updates driver and returns to show", %{conn: conn, driver: driver} do
      {:ok, show_live, _html} = live(conn, ~p"/drivers/#{driver}")

      assert {:ok, form_live, _} =
               show_live
               |> element("a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/drivers/#{driver}/edit?return_to=show")

      assert render(form_live) =~ "Edit Driver"

      assert form_live
             |> form("#driver-form", driver: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, show_live, _html} =
               form_live
               |> form("#driver-form", driver: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/drivers/#{driver}")

      html = render(show_live)
      assert html =~ "Driver updated successfully"
      assert html =~ "some updated vehicle_model"
    end
  end
end
