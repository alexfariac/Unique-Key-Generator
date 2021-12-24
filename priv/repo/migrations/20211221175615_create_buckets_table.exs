defmodule Unikey.Repo.Migrations.CreateBucketsTable do
  use Ecto.Migration

  def change do
    create table(:bucket) do
      add(:bucket, :string)
      add(:sequence, :integer, default: 0)
      add(:account, :string)

      add(:prefix, :string)
      add(:suffix, :string)
      add(:random_offset, :boolean, default: false)
      timestamps()
    end

    create(index(:bucket, [:bucket], comment: "Index for retrieving bucket by name"))
    create(unique_index(:bucket, [:bucket, :account]))
  end
end
