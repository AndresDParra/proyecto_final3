defmodule MyApp.AuthTest do
  use MyApp.DataCase

  alias MyApp.Auth

  describe "roles" do
    alias MyApp.Auth.Role

    import MyApp.AuthFixtures

    @invalid_attrs %{name: nil}

    test "list_roles/0 returns all roles" do
      role = role_fixture()
      assert Auth.list_roles() == [role]
    end

    test "get_role!/1 returns the role with given id" do
      role = role_fixture()
      assert Auth.get_role!(role.id) == role
    end

    test "create_role/1 with valid data creates a role" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Role{} = role} = Auth.create_role(valid_attrs)
      assert role.name == "some name"
    end

    test "create_role/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Auth.create_role(@invalid_attrs)
    end

    test "update_role/2 with valid data updates the role" do
      role = role_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Role{} = role} = Auth.update_role(role, update_attrs)
      assert role.name == "some updated name"
    end

    test "update_role/2 with invalid data returns error changeset" do
      role = role_fixture()
      assert {:error, %Ecto.Changeset{}} = Auth.update_role(role, @invalid_attrs)
      assert role == Auth.get_role!(role.id)
    end

    test "delete_role/1 deletes the role" do
      role = role_fixture()
      assert {:ok, %Role{}} = Auth.delete_role(role)
      assert_raise Ecto.NoResultsError, fn -> Auth.get_role!(role.id) end
    end

    test "change_role/1 returns a role changeset" do
      role = role_fixture()
      assert %Ecto.Changeset{} = Auth.change_role(role)
    end
  end

  describe "users" do
    alias MyApp.Auth.User

    import MyApp.AuthFixtures

    @invalid_attrs %{name: nil, username: nil, password: nil}

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Auth.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Auth.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{name: "some name", username: "some username", password: "some password"}

      assert {:ok, %User{} = user} = Auth.create_user(valid_attrs)
      assert user.name == "some name"
      assert user.username == "some username"
      assert user.password == "some password"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Auth.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      update_attrs = %{name: "some updated name", username: "some updated username", password: "some updated password"}

      assert {:ok, %User{} = user} = Auth.update_user(user, update_attrs)
      assert user.name == "some updated name"
      assert user.username == "some updated username"
      assert user.password == "some updated password"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Auth.update_user(user, @invalid_attrs)
      assert user == Auth.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Auth.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Auth.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Auth.change_user(user)
    end
  end

  describe "drivers" do
    alias MyApp.Auth.Driver

    import MyApp.AuthFixtures

    @invalid_attrs %{vehicle_model: nil, vehicle_plate: nil}

    test "list_drivers/0 returns all drivers" do
      driver = driver_fixture()
      assert Auth.list_drivers() == [driver]
    end

    test "get_driver!/1 returns the driver with given id" do
      driver = driver_fixture()
      assert Auth.get_driver!(driver.id) == driver
    end

    test "create_driver/1 with valid data creates a driver" do
      valid_attrs = %{vehicle_model: "some vehicle_model", vehicle_plate: "some vehicle_plate"}

      assert {:ok, %Driver{} = driver} = Auth.create_driver(valid_attrs)
      assert driver.vehicle_model == "some vehicle_model"
      assert driver.vehicle_plate == "some vehicle_plate"
    end

    test "create_driver/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Auth.create_driver(@invalid_attrs)
    end

    test "update_driver/2 with valid data updates the driver" do
      driver = driver_fixture()
      update_attrs = %{vehicle_model: "some updated vehicle_model", vehicle_plate: "some updated vehicle_plate"}

      assert {:ok, %Driver{} = driver} = Auth.update_driver(driver, update_attrs)
      assert driver.vehicle_model == "some updated vehicle_model"
      assert driver.vehicle_plate == "some updated vehicle_plate"
    end

    test "update_driver/2 with invalid data returns error changeset" do
      driver = driver_fixture()
      assert {:error, %Ecto.Changeset{}} = Auth.update_driver(driver, @invalid_attrs)
      assert driver == Auth.get_driver!(driver.id)
    end

    test "delete_driver/1 deletes the driver" do
      driver = driver_fixture()
      assert {:ok, %Driver{}} = Auth.delete_driver(driver)
      assert_raise Ecto.NoResultsError, fn -> Auth.get_driver!(driver.id) end
    end

    test "change_driver/1 returns a driver changeset" do
      driver = driver_fixture()
      assert %Ecto.Changeset{} = Auth.change_driver(driver)
    end
  end
end
