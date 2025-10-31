defmodule MyApp.User do
  use Ecto.Schema

  schema "users" do
    field :name, :string
    # Note: lowercase 'id' is more conventional
    field :ID, :string
    embeds_one :residence, MyApp.Address
    field :phone_number, :string
    # Added missing type
    embeds_one :bank_account, MyApp.BankAccount

    timestamps()
  end
end

