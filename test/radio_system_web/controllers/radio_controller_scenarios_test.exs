defmodule RadioSystemWeb.RadioControllerScenariosTest do
  use RadioSystemWeb.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "scnarios" do
    test "scnario 1", %{conn: conn} do
      [radio1, radio2] = [
        %{
          alias: "Radio100",
          allowed_locations: ["CPH-1", "CPH-2"]
        },
        radio2 = %{
          alias: "Radio101",
          allowed_locations: ["CPH-1", "CPH-2", "CPH-3"]
        }
      ]

      conn = post(conn, "/radios/100", radio1)
      assert %{} = json_response(conn, 201)

      conn = post(conn, "/radios/101", radio2)
      assert %{} = json_response(conn, 201)

      conn = post(conn, "/radios/100/location", %{location: "CPH-1"})
      assert json_response(conn, 200)

      conn = post(conn, "/radios/101/location", %{location: "CPH-3"})
      assert json_response(conn, 200)

      conn = post(conn, "/radios/100/location", %{location: "CPH-3"})
      assert json_response(conn, 403)

      conn = get(conn, "/radios/101/location")
      assert %{"location" => "CPH-3"} = json_response(conn, 200)

      conn = get(conn, "/radios/100/location")
      assert %{"location" => "CPH-1"} = json_response(conn, 200)
    end
  end
end
