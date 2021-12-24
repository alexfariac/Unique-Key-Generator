defmodule Unikey.Bucket do
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  @required_params [:bucket, :account]
  @all_params @required_params ++ [:prefix, :suffix, :random_offset, :sequence]

  @derive {Jason.Encoder, only: @all_params}

  schema "bucket" do
    field :bucket, :string
    field :sequence, :integer, default: 0
    field :account, :string

    field :prefix, :string
    field :suffix, :string
    field :random_offset, :boolean, default: false

    timestamps()
  end

  def changeset(params) do
    IO.inspect(params, label: "Bucket in changeset")

    %__MODULE__{}
    |> cast(params, @all_params)
    |> validate_required(@required_params)
    |> validate_length(:bucket, min: 2, max: 50)
    |> validate_length(:account, min: 2, max: 50)
    |> validate_length(:prefix, max: 5)
    |> validate_length(:suffix, max: 5)
    |> validate_number(:sequence, greater_than_or_equal_to: 0)
    |> unique_constraint([:bucket, :account])
  end
end
