defmodule PlvReact.Repo do
  use Ecto.Repo,
    otp_app: :plv_react,
    adapter: Ecto.Adapters.Postgres
end
