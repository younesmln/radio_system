defmodule RadioSystemWeb.RadioController do
  use RadioSystemWeb, :controller

  alias RadioSystem.Devices
  alias RadioSystem.Devices.Radio

  action_fallback RadioSystemWeb.FallbackController

  def index(conn, _params) do
    radios = Devices.list_radios()
    render(conn, "index.json", radios: radios)
  end

  def create(conn, radio_params) do
    with {:ok, %Radio{} = radio} <- Devices.create_radio(radio_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.radio_path(conn, :show, radio))
      |> render("show.json", radio: radio)
    end
  end

  def show(conn, %{"id" => id}) do
    radio = Devices.get_radio!(id)
    render(conn, "show.json", radio: radio)
  end

  def current_location(conn, %{"radio_id" => radio_id}) do
    %Radio{location: location} = Devices.get_radio!(radio_id)

    with %Radio{location: location} = radio when not is_nil(location) <-
           Devices.get_radio!(radio_id) do
      render(conn, "radio_location.json", radio: radio)
    else
      _ ->
        conn
        |> put_status(:not_found)
        |> json(%{})
    end
  end

  def update_location(conn, %{"radio_id" => radio_id} = radio_params) do
    radio = Devices.get_radio!(radio_id)

    with {:ok, %Radio{} = _radio} <- Devices.update_radio_location(radio, radio_params) do
      json(conn, %{})
    else
      _ ->
        conn
        |> put_status(:forbidden)
        |> json(%{})
    end
  end
end
