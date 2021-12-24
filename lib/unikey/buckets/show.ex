defmodule Unikey.Buckets.Show do
  alias Unikey.{Repo, Bucket}

  def call(bucket_name) do
    case Repo.get_by(Bucket, bucket: bucket_name) do
      nil -> {:error, %{result: "Bucket not found", status: :bad_request}}
      %Bucket{} = bucket -> {:ok, bucket}
    end
  end
end
