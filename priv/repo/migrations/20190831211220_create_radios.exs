defmodule RadioSystem.Repo.Migrations.CreateRadios do
  use Ecto.Migration

  def change do
    create table(:radios) do
      add :alias, :string, null: false
      add :allowed_locations, {:array, :string}, default: []
      add :location, :string

      timestamps()
    end
  end
end
