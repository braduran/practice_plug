defmodule Movies.Repositories.Repo.Migrations.Movie do
  use Ecto.Migration

  def change do
    create table(:movie) do
      add :code, :integer
      add :title, :string
      add :author, :string
    end
  end
end
