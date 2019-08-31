defmodule RadioSystemWeb.Router do
  use RadioSystemWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", RadioSystemWeb do
    pipe_through :api
  end
end
