# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :plv_react,
  ecto_repos: [PlvReact.Repo]

# Configures the endpoint
config :plv_react, PlvReactWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "1tm4XdEKkKFO4ac7TxkISZfp0ZvxJYxADPQDRJ1reM9hJlwN4wS6AioawkJjpvOl",
  render_errors: [view: PlvReactWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: PlvReact.PubSub,
  live_view: [signing_salt: "dEh8PATK"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
