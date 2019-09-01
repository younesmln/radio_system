defmodule RadioSystemWeb.RadioControllerTest do
  use RadioSystemWeb.ConnCase

  alias RadioSystem.Devices
  alias RadioSystem.Devices.Radio

  @create_attrs %{
    alias: "Radio100",
    allowed_locations: ["CPH-1", "CPH-2"]
  }

  @invalid_attrs %{alias: nil, allowed_locations: nil, location: nil}

  def fixture(:radio, attrs \\ @create_attrs) do
    {:ok, radio} = Devices.create_radio(attrs)
    radio
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "fetch radios" do
    test "lists all radios", %{conn: conn} do
      conn = get(conn, Routes.radio_path(conn, :index))
      assert json_response(conn, 200) == []
    end
  end

  describe "create radio" do
    test "creates and renders radio when data is valid", %{conn: conn} do
      radio_id = 100
      conn = post(conn, Routes.radio_path(conn, :create, radio_id), @create_attrs)

      result = %{
        "alias" => "Radio100",
        "allowed_locations" => ["CPH-1", "CPH-2"]
      }

      assert ^result = json_response(conn, 201)

      conn = get(conn, Routes.radio_path(conn, :show, radio_id))
      assert ^result = json_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn} do
      radio_id = 100
      conn = post(conn, Routes.radio_path(conn, :create, radio_id), @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update radio location" do
    setup [:create_radio]

    test "returns status code 200 when data is valid", %{conn: conn, radio: %Radio{} = radio} do
      conn =
        post(conn, Routes.radio_location_path(conn, :update_location, radio), %{location: "CPH-1"})

      assert %{} = json_response(conn, 200)
    end

    test "403 FORBIDDEN for invalid location", %{conn: conn, radio: radio} do
      conn =
        post(conn, Routes.radio_location_path(conn, :update_location, radio), %{
          location: "CPH-1-test"
        })

      assert json_response(conn, 403)
    end
  end

  describe "get radio location" do
    setup [:create_radio]

    test "returns status code 200 when data is valid", %{conn: conn, radio: %Radio{} = radio} do
      update_location(radio, "CPH-1")
      conn = get(conn, Routes.radio_location_path(conn, :current_location, radio.id))
      assert %{"location" => "CPH-1"} = json_response(conn, 200)
    end

    test "403 FORBIDDEN for invalid location", %{conn: conn, radio: radio} do
      conn = get(conn, Routes.radio_location_path(conn, :current_location, radio.id))
      assert json_response(conn, 404)
    end
  end

  defp create_radio(_) do
    radio = fixture(:radio)
    {:ok, radio: radio}
  end

  defp update_location(radio, location) do
    {:ok, %Radio{} = radio} = Devices.update_radio_location(radio, %{location: location})
    radio
  end
end
