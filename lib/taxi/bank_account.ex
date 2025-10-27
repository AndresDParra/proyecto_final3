defmodule Taxi.BankAccount do
  use Ecto.Schema

  schema "bank_account" do
    field(bank: :string)
    field(balance: :integer)
    field(account_number: :integer)

    timestamps()
  end
end
