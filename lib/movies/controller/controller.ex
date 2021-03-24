defmodule Movies.Controller.Controller do
  alias Movies.Repositories.MovieGateway

  require Logger

  def get_all_movies do
    MovieGateway.list_all_movies()
  end

  def get_movie_by_code(code) do
    MovieGateway.movie_by_code(code)
  end

  def save_movie(movie) do
    MovieGateway.save_movie(movie)
  end

  def delete_movie(code) do
    MovieGateway.delete_movie(code)
  end
end
