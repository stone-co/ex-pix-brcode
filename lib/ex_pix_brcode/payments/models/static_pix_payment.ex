defmodule ExPixBRCode.Payments.Models.StaticPixPayment do
  @moduledoc """
  A static Pix payment model.

  Static payments are those meant to be used many times. Normally a merchant will print a QRCode to
  a sign and direct his/her customers to scan it. It MUST contain AT LEAST the DICT key for the
  target account.
  """

  use ExPixBRCode.ValueObject

  @required [:key]
  @optional [:transaction_amount, :transaction_id, :additional_information]

  embedded_schema do
    field :key, :string
    field :key_type, :string
    field :additional_information, :string
    field :transaction_amount, :string
    field :transaction_id, :string
  end

  @doc false
  def changeset(model \\ %__MODULE__{}, params) do
    model
    |> cast(params, @required ++ @optional)
    |> validate_required(@required)
    |> validate_length(:transaction_amount, max: 13)
    |> validate_format(:transaction_amount, ~r/(^0$)|(^[0-9]+\.[0-9]*$)/)
    |> validate_format(:transaction_id, ~r/^[a-zA-Z0-9]{1,25}$/)
  end
end
