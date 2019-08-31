defmodule RadioSystem.Repo do
  use Ecto.Repo,
    otp_app: :radio_system,
    adapter: Ecto.Adapters.Postgres
end
