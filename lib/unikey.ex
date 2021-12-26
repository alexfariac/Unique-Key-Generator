defmodule Unikey do
  @moduledoc """
  Unikey keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  alias Unikey.Keys.Create, as: KeysCreate
  alias Unikey.Buckets.Create, as: BucketsCreate
  alias Unikey.Buckets.Show, as: BucketsShow
  alias Unikey.Buckets.IncreaseSequence, as: BucketIncreaseSequence

  defdelegate create_bucket(params), to: BucketsCreate, as: :call
  defdelegate get_bucket(bucket_name), to: BucketsShow, as: :call

  defdelegate increase_sequence(bucket_name, offset),
    to: BucketIncreaseSequence,
    as: :increase_sequence

  defdelegate create_key(bucket_name), to: KeysCreate, as: :call
end
