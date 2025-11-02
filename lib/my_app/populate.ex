defmodule Mytest do
  def update_user(id, name, username, password, id_role) do
    MyApp.Auth.update_user(get_user(id), %{
      username: username,
      name: name,
      password: password,
      role_id: id_role
    })
  end

  def create_client(username, name, password) do
    MyApp.Auth.create_user(%{
      username: username,
      name: name,
      password: password,
      role_id: MyApp.Auth.get_role!(1)
    })
  end

def create_taxi(username, name, password) do
    MyApp.Auth.create_user(%{
      username: username,
      name: name,
      password: password,
      role_id: MyApp.Auth.get_role!(2)
    })
  end


  def get_user(id) do
    MyApp.Auth.get_user!(id)
  end

  def delete_user(id) do
    user = get_user(id)
    MyApp.Auth.delete_user(user)
  end

  def dummy_user do
    MyApp.Auth.create_user(%{
      username: "dummy_usernaame",
      name: "Mr.Dummy",
      password: "dummy_pwd",
      role_id: 1
    })
  end
end
