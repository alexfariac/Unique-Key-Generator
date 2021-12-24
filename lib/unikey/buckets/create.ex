defmodule Unikey.Buckets.Create do
  alias Unikey.{Repo, Bucket}

  def call(params) do
    params
    |> Bucket.changeset()
    |> Repo.insert()
    |> handle_insert()
  end

  def handle_insert({:ok, %Bucket{}} = result), do: result

  def handle_insert({:error, result}), do: {:error, %{result: result, status: :bad_request}}
end
