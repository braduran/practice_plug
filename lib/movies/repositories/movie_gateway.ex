defmodule Movies.Repositories.MovieGateway do
  alias Movies.Repositories.Repo
  alias Movies.Repositories.Movie

  import Ecto.Query, warn: false

  def list_all_movies do
    Movie
    |> Repo.all()
    |> extract()
  end

  def save_movie(movie) do
    {:ok, movie} = Repo.insert(movie)
    {:ok, %{message: "Movie insertada con exito", movie: delete_meta(movie)}}
  end

  def delete_movie(id) do
    case Repo.get(Movie, id) do
      nil -> %{message: "Error al borrar movie", id: id}
      movie ->
        Repo.delete(movie)
        {:ok, %{message: "Movie borrada con exito", id: id}}
    end
  end

  defp extract(result) when is_list(result), do: {:ok, delete_meta(result)}

  defp extract(result) do
    case result do
      %Movie{} = movie -> {:ok, movie}
      {:ok, %Movie{} = movie} -> {:ok, movie}
      nil -> {:error, :not_found}
      other -> {:error, other}
    end
  end

  defp delete_meta(result) when is_list(result) do
    Enum.map(result, fn movie -> Map.delete(movie, :__meta__) end)
  end

  defp delete_meta(result) when is_map(result)  do
    Map.delete(result, :__meta__)
  end

end
