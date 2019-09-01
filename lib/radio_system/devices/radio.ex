defmodule RadioSystem.Devices.Radio do
  use Ecto.Schema
  import Ecto.Changeset

  schema "radios" do
    field :alias, :string
    field :allowed_locations, {:array, :string}
    field :location, :string

    timestamps()
  end

  @doc false
  def create_changeset(radio, attrs) do
    radio
    |> cast(attrs, [:id, :alias, :allowed_locations])
    |> validate_required([:alias])
  end

  def update_location_changeset(radio, attrs) do
    radio
    |> cast(attrs, [:location])
    |> validate_required([:location])
    |> validate_inclusion(:location, radio.allowed_locations)
  end
end
