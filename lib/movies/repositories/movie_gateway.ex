defmodule Movies.Repositories.MovieGateway do
  alias Movies.Repositories.Repo
  alias Movies.Repositories.Movie

  import Ecto.Query, warn: false

  def list_all_movies do
    case Repo.all(Movie) do
      [] -> {:ok, %{message: "No hay peliculas registradas"}}
      movies -> {:ok, delete_any_data(movies)}
    end
  end

  def movie_by_code(code) do
    query = from(m in Movie, where: m.code == ^code)
    case Repo.all(query) do
      [] -> {:error, %{message: "Movie no encontrada", code: code}}
      [%Movie{} = m] -> {:ok, delete_any_data(m)}
    end
  end

  def save_movie(movie) do
    query = from(m in Movie, where: m.code == ^movie.code)

    case Repo.all(query) do
      [] -> Repo.insert(movie)
            {:ok, %{message: "Movie insertada con exito", code: movie.code}}
      [%Movie{} = m] -> {:error, %{message: "Movie ya existe", code: m.code}}
    end
  end

  def delete_movie(code) do
    query = from(m in Movie, where: m.code == ^code)
    case Repo.delete_all(query) do
      {0, nil} -> {:error, %{message: "Movie no encontrada", code: code}}
      {n, nil} -> {:ok, %{message: "Movie(s) borrada con exito", num_movies: n}}
    end
  end

  defp delete_any_data(result) when is_list(result) do
    Enum.map(result, fn movie -> Map.drop(movie, [:__meta__, :id, :__struct__]) end)
  end

  defp delete_any_data(result) when is_map(result)  do
    Map.drop(result, [:__meta__, :id, :__struct__])
  end

end
