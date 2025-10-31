defmodule Taxi.BankAccount do
  use Ecto.Schema

  embedded_schema do
    field :bank, :string
    field :balance, :integer
    field :account_number, :integer


    timestamps()
  end
end

