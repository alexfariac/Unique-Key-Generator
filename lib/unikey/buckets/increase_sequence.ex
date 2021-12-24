defmodule Unikey.Buckets.IncreaseSequence do
  import Ecto.Query

  alias Unikey.Repo
  alias Unikey.Bucket

  def increase_sequence(bucket_name, offset) do
    now = NaiveDateTime.utc_now()

    query =
      from Bucket,
        where: [bucket: ^bucket_name],
        update: [inc: [sequence: ^offset], set: [updated_at: ^now]],
        select: [:sequence]

    query
    |> Repo.update_all([])
    |> fetch_increased_sequence()
  end

  defp fetch_increased_sequence({updated_records, [%Bucket{sequence: sequence}]})
       when updated_records == 1 do
    {:ok, sequence}
  end
end
