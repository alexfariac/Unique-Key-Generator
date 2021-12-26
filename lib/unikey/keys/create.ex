defmodule Unikey.Keys.Create do
  alias Unikey.{Key, Bucket}

  @seconds_to_hours 60 * 60
  @start_date ~D[2010-01-01]

  def call(bucket_name) do
    with {:ok, %Bucket{prefix: pref, suffix: suf, random_offset: random_offset}} <-
           Unikey.get_bucket(bucket_name),
         offset = Bucket.get_offset(random_offset),
         {:ok, sequence} <- Unikey.increase_sequence(bucket_name, offset) do
      key_id = generate_key_id(%{prefix: pref, suffix: suf, sequence: sequence})

      {:ok,
       %Key{
         key_id: key_id,
         bucket: bucket_name,
         sequence: sequence,
         creation_date: DateTime.utc_now()
       }}
    end
  end

  defp generate_key_id(%{prefix: nil, suffix: nil, sequence: _sequence}) do
    now = DateTime.utc_now()
    start_date = @start_date

    year_begin = %DateTime{
      year: now.year,
      month: 01,
      day: 01,
      hour: 00,
      minute: 00,
      second: 00,
      time_zone: now.time_zone,
      std_offset: now.std_offset,
      utc_offset: now.utc_offset,
      zone_abbr: now.zone_abbr
    }

    %{year_begin | year: now.year}

    year_diff = year_begin.year - start_date.year
    hour_diff = DateTime.diff(now, year_begin) |> div(@seconds_to_hours)
    now_min = now.minute
    now_sec = now.second
    rand = :rand.uniform(999)

    "#{year_diff}#{hour_diff}#{now_min}#{now_sec}#{rand}"
  end

  defp generate_key_id(%{prefix: pref, suffix: suf, sequence: sequence}) do
    "#{pref}#{sequence}#{suf}"
  end
end
