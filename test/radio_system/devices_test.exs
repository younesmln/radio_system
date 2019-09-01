defmodule RadioSystem.DevicesTest do
  use RadioSystem.DataCase

  alias RadioSystem.Devices

  describe "radios" do
    alias RadioSystem.Devices.Radio

    @valid_attrs %{alias: "some alias", allowed_locations: ["CPH-1"], location: "some location"}
    @update_attrs %{
      alias: "some updated alias",
      allowed_locations: [],
      location: "some updated location"
    }
    @invalid_attrs %{alias: nil, allowed_locations: nil, location: nil}

    def radio_fixture(attrs \\ %{}) do
      {:ok, radio} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Devices.create_radio()

      radio
    end

    test "list_radios/0 returns all radios" do
      radio = radio_fixture()
      assert Devices.list_radios() == [radio]
    end

    test "get_radio!/1 returns the radio with given id" do
      radio = radio_fixture()
      assert Devices.get_radio!(radio.id) == radio
    end

    test "create_radio/1 with valid data creates a radio" do
      assert {:ok, %Radio{} = radio} = Devices.create_radio(@valid_attrs)
      assert radio.alias == "some alias"
      assert radio.allowed_locations == ["CPH-1"]
    end

    test "create_radio/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Devices.create_radio(@invalid_attrs)
    end

    test "update radio location with invalid location fails" do
      radio = radio_fixture()

      assert {:error, %Ecto.Changeset{errors: [location: _]}} =
               Devices.update_radio_location(radio, %{location: "new loction"})
    end
  end
end
