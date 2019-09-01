defmodule RadioSystemWeb.Router do
  use RadioSystemWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", RadioSystemWeb do
    pipe_through :api

    scope "/radios" do
      get "/", RadioController, :index
      get "/:id", RadioController, :show
      post "/:id", RadioController, :create

      scope "/", as: :radio do
        post "/:radio_id/location", RadioController, :update_location, as: :location
        get "/:radio_id/location", RadioController, :current_location, as: :location
      end
    end
  end
end
