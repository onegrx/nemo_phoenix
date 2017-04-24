# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :nemo,
  ecto_repos: [Nemo.Repo]

# Configures the endpoint
config :nemo, Nemo.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "kHk1H9ogC7jtZz3Qxh/qXVcdzJvm4WlwZuaJTlhguAdH43Rg5M8FufYSKPUSsKPW",
  render_errors: [view: Nemo.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Nemo.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
