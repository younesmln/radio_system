defmodule RadioSystem.Devices do
  @moduledoc """
  The Devices context.
  """

  import Ecto.Query, warn: false
  alias RadioSystem.Repo

  alias RadioSystem.Devices.Radio

  @doc """
  Returns the list of radios.

  ## Examples

      iex> list_radios()
      [%Radio{}, ...]

  """
  def list_radios do
    Repo.all(Radio)
  end

  @doc """
  Gets a single radio.

  Raises `Ecto.NoResultsError` if the Radio does not exist.

  ## Examples

      iex> get_radio!(123)
      %Radio{}

      iex> get_radio!(456)
      ** (Ecto.NoResultsError)

  """
  def get_radio!(id), do: Repo.get!(Radio, id)

  @doc """
  Creates a radio.

  ## Examples

      iex> create_radio(%{field: value})
      {:ok, %Radio{}}

      iex> create_radio(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_radio(attrs \\ %{}) do
    %Radio{}
    |> Radio.create_changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a radio.

  ## Examples

      iex> update_radio(radio, %{field: new_value})
      {:ok, %Radio{}}

      iex> update_radio(radio, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_radio_location(%Radio{} = radio, attrs) do
    radio
    |> Radio.update_location_changeset(attrs)
    |> Repo.update()
  end
end
