defmodule MyApp.TaxiTest do
  use MyApp.DataCase

  alias MyApp.Taxi

  describe "travel_requests" do
    alias MyApp.Taxi.TravelRequest

    import MyApp.TaxiFixtures

    @invalid_attrs %{status: nil}

    test "list_travel_requests/0 returns all travel_requests" do
      travel_request = travel_request_fixture()
      assert Taxi.list_travel_requests() == [travel_request]
    end

    test "get_travel_request!/1 returns the travel_request with given id" do
      travel_request = travel_request_fixture()
      assert Taxi.get_travel_request!(travel_request.id) == travel_request
    end

    test "create_travel_request/1 with valid data creates a travel_request" do
      valid_attrs = %{status: "some status"}

      assert {:ok, %TravelRequest{} = travel_request} = Taxi.create_travel_request(valid_attrs)
      assert travel_request.status == "some status"
    end

    test "create_travel_request/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Taxi.create_travel_request(@invalid_attrs)
    end

    test "update_travel_request/2 with valid data updates the travel_request" do
      travel_request = travel_request_fixture()
      update_attrs = %{status: "some updated status"}

      assert {:ok, %TravelRequest{} = travel_request} = Taxi.update_travel_request(travel_request, update_attrs)
      assert travel_request.status == "some updated status"
    end

    test "update_travel_request/2 with invalid data returns error changeset" do
      travel_request = travel_request_fixture()
      assert {:error, %Ecto.Changeset{}} = Taxi.update_travel_request(travel_request, @invalid_attrs)
      assert travel_request == Taxi.get_travel_request!(travel_request.id)
    end

    test "delete_travel_request/1 deletes the travel_request" do
      travel_request = travel_request_fixture()
      assert {:ok, %TravelRequest{}} = Taxi.delete_travel_request(travel_request)
      assert_raise Ecto.NoResultsError, fn -> Taxi.get_travel_request!(travel_request.id) end
    end

    test "change_travel_request/1 returns a travel_request changeset" do
      travel_request = travel_request_fixture()
      assert %Ecto.Changeset{} = Taxi.change_travel_request(travel_request)
    end
  end
end
