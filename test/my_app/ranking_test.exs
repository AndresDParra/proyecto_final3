defmodule MyApp.RankingTest do
  use MyApp.DataCase

  alias MyApp.Ranking

  describe "results_and_ranking" do
    alias MyApp.Ranking.Result

    import MyApp.RankingFixtures

    @invalid_attrs %{status: nil, origin: nil, date_trip: nil, passenger_points: nil, driver_points: nil}

    test "list_results_and_ranking/0 returns all results_and_ranking" do
      result = result_fixture()
      assert Ranking.list_results_and_ranking() == [result]
    end

    test "get_result!/1 returns the result with given id" do
      result = result_fixture()
      assert Ranking.get_result!(result.id) == result
    end

    test "create_result/1 with valid data creates a result" do
      valid_attrs = %{status: "some status", origin: "some origin", date_trip: ~N[2025-10-31 22:07:00], passenger_points: 42, driver_points: 42}

      assert {:ok, %Result{} = result} = Ranking.create_result(valid_attrs)
      assert result.status == "some status"
      assert result.origin == "some origin"
      assert result.date_trip == ~N[2025-10-31 22:07:00]
      assert result.passenger_points == 42
      assert result.driver_points == 42
    end

    test "create_result/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Ranking.create_result(@invalid_attrs)
    end

    test "update_result/2 with valid data updates the result" do
      result = result_fixture()
      update_attrs = %{status: "some updated status", origin: "some updated origin", date_trip: ~N[2025-11-01 22:07:00], passenger_points: 43, driver_points: 43}

      assert {:ok, %Result{} = result} = Ranking.update_result(result, update_attrs)
      assert result.status == "some updated status"
      assert result.origin == "some updated origin"
      assert result.date_trip == ~N[2025-11-01 22:07:00]
      assert result.passenger_points == 43
      assert result.driver_points == 43
    end

    test "update_result/2 with invalid data returns error changeset" do
      result = result_fixture()
      assert {:error, %Ecto.Changeset{}} = Ranking.update_result(result, @invalid_attrs)
      assert result == Ranking.get_result!(result.id)
    end

    test "delete_result/1 deletes the result" do
      result = result_fixture()
      assert {:ok, %Result{}} = Ranking.delete_result(result)
      assert_raise Ecto.NoResultsError, fn -> Ranking.get_result!(result.id) end
    end

    test "change_result/1 returns a result changeset" do
      result = result_fixture()
      assert %Ecto.Changeset{} = Ranking.change_result(result)
    end
  end

  describe "results_and_ranking" do
    alias MyApp.Ranking.Result

    import MyApp.RankingFixtures

    @invalid_attrs %{status: nil, origin: nil, date_trip: nil, passenger_points: nil, driver_points: nil}

    test "list_results_and_ranking/0 returns all results_and_ranking" do
      result = result_fixture()
      assert Ranking.list_results_and_ranking() == [result]
    end

    test "get_result!/1 returns the result with given id" do
      result = result_fixture()
      assert Ranking.get_result!(result.id) == result
    end

    test "create_result/1 with valid data creates a result" do
      valid_attrs = %{status: "some status", origin: "some origin", date_trip: ~N[2025-11-01 18:40:00], passenger_points: 42, driver_points: 42}

      assert {:ok, %Result{} = result} = Ranking.create_result(valid_attrs)
      assert result.status == "some status"
      assert result.origin == "some origin"
      assert result.date_trip == ~N[2025-11-01 18:40:00]
      assert result.passenger_points == 42
      assert result.driver_points == 42
    end

    test "create_result/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Ranking.create_result(@invalid_attrs)
    end

    test "update_result/2 with valid data updates the result" do
      result = result_fixture()
      update_attrs = %{status: "some updated status", origin: "some updated origin", date_trip: ~N[2025-11-02 18:40:00], passenger_points: 43, driver_points: 43}

      assert {:ok, %Result{} = result} = Ranking.update_result(result, update_attrs)
      assert result.status == "some updated status"
      assert result.origin == "some updated origin"
      assert result.date_trip == ~N[2025-11-02 18:40:00]
      assert result.passenger_points == 43
      assert result.driver_points == 43
    end

    test "update_result/2 with invalid data returns error changeset" do
      result = result_fixture()
      assert {:error, %Ecto.Changeset{}} = Ranking.update_result(result, @invalid_attrs)
      assert result == Ranking.get_result!(result.id)
    end

    test "delete_result/1 deletes the result" do
      result = result_fixture()
      assert {:ok, %Result{}} = Ranking.delete_result(result)
      assert_raise Ecto.NoResultsError, fn -> Ranking.get_result!(result.id) end
    end

    test "change_result/1 returns a result changeset" do
      result = result_fixture()
      assert %Ecto.Changeset{} = Ranking.change_result(result)
    end
  end

  describe "results_and_ranking" do
    alias MyApp.Ranking.Result

    import MyApp.RankingFixtures

    @invalid_attrs %{status: nil, origin: nil, date_trip: nil, passenger_points: nil, driver_points: nil}

    test "list_results_and_ranking/0 returns all results_and_ranking" do
      result = result_fixture()
      assert Ranking.list_results_and_ranking() == [result]
    end

    test "get_result!/1 returns the result with given id" do
      result = result_fixture()
      assert Ranking.get_result!(result.id) == result
    end

    test "create_result/1 with valid data creates a result" do
      valid_attrs = %{status: "some status", origin: "some origin", date_trip: ~N[2025-11-01 18:59:00], passenger_points: 42, driver_points: 42}

      assert {:ok, %Result{} = result} = Ranking.create_result(valid_attrs)
      assert result.status == "some status"
      assert result.origin == "some origin"
      assert result.date_trip == ~N[2025-11-01 18:59:00]
      assert result.passenger_points == 42
      assert result.driver_points == 42
    end

    test "create_result/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Ranking.create_result(@invalid_attrs)
    end

    test "update_result/2 with valid data updates the result" do
      result = result_fixture()
      update_attrs = %{status: "some updated status", origin: "some updated origin", date_trip: ~N[2025-11-02 18:59:00], passenger_points: 43, driver_points: 43}

      assert {:ok, %Result{} = result} = Ranking.update_result(result, update_attrs)
      assert result.status == "some updated status"
      assert result.origin == "some updated origin"
      assert result.date_trip == ~N[2025-11-02 18:59:00]
      assert result.passenger_points == 43
      assert result.driver_points == 43
    end

    test "update_result/2 with invalid data returns error changeset" do
      result = result_fixture()
      assert {:error, %Ecto.Changeset{}} = Ranking.update_result(result, @invalid_attrs)
      assert result == Ranking.get_result!(result.id)
    end

    test "delete_result/1 deletes the result" do
      result = result_fixture()
      assert {:ok, %Result{}} = Ranking.delete_result(result)
      assert_raise Ecto.NoResultsError, fn -> Ranking.get_result!(result.id) end
    end

    test "change_result/1 returns a result changeset" do
      result = result_fixture()
      assert %Ecto.Changeset{} = Ranking.change_result(result)
    end
  end
end
