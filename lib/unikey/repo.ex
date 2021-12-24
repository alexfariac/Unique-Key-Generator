defmodule Unikey.Repo do
  use Ecto.Repo,
    otp_app: :unikey,
    adapter: Ecto.Adapters.Postgres
end
