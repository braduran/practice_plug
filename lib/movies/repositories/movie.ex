defmodule Movies.Repositories.Movie do
  use Ecto.Schema
  import Ecto.Changeset

  #@primary_key{:id, :integer, []}
  #@derive {Poison.Encoder, only: [:id,:code, :title, :author]}
  schema "movies" do
    field(:code, :integer)
    field(:title, :string)
    field(:author, :string)
  end

  def changeset(movie, attrs) do
    movie
    |> cast(attrs, [:code, :title, :author])
    |> validate_required([:code, :title, :author])
  end
end
