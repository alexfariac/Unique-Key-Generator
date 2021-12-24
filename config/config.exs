# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :unikey,
  ecto_repos: [Unikey.Repo]

config :unikey, Unikey.Repo,
  migration_primary_key: [type: :binary_id],
  migration_foreign_key: [type: :binary_id]

# Configures the endpoint
config :unikey, UnikeyWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "zbZ1fYTQOhX5fA9lJGONH4R2kYl7sWdH9egaKIcnAcIy83VmMNdvOqHSdNXReUjd",
  render_errors: [view: UnikeyWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Unikey.PubSub,
  live_view: [signing_salt: "CBKK+eB8"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
