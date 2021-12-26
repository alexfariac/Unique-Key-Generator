defmodule Unikey.Key do
  @all_params [:key_id, :bucket, :sequence, :creation_date]

  @derive {Jason.Encoder, only: @all_params}

  @enforce_keys @all_params
  defstruct @all_params
end
