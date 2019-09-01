defmodule RadioSystemWeb.RadioView do
  use RadioSystemWeb, :view
  alias RadioSystemWeb.RadioView

  def render("index.json", %{radios: radios}) do
    render_many(radios, RadioView, "radio.json")
  end

  def render("show.json", %{radio: radio}) do
    render_one(radio, RadioView, "radio.json")
  end

  def render("radio_location.json", %{radio: radio}) do
    Map.take(radio, [:location])
  end

  def render("radio.json", %{radio: radio}) do
    %{alias: radio.alias, allowed_locations: radio.allowed_locations}
  end
end
