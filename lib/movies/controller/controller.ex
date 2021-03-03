defmodule Movies.Controller.Controller do
  alias Movies.Repositories.MovieGateway

  require Logger

  def get_all_movies do
    with{:ok, movie_list} = MovieGateway.list_all_movies() do
      movie_list
    else
      error -> Logger.error("Error en listar las peliculas en Controller " <> error)
    end
  end

  def save_movie(movie) do
    with {:ok, message} = MovieGateway.save_movie(movie) do
      message
    else
      error -> Logger.error("Error al guardar pelicula en Controller " <> error)
    end
  end

  def delete_movie(id) do
    with {:ok, message} <- MovieGateway.delete_movie(id) do
      message
    else
      error -> Logger.error("Error al eliminar pelicula en Controller ", error)
      error
    end
  end
end
