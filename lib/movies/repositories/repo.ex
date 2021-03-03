defmodule Movies.Repositories.Repo do
  alias Ecto.Adapters.SQL
  alias DBConnection.ConnectionError

  use Ecto.Repo,
    otp_app: :practice_movies,
    adapter: Ecto.Adapters.Postgres

  def health() do
    try do
      case SQL.query(__MODULE__, "select 1", []) do
        {:ok, _res} -> {:ok, :up}
        _error -> :error
      end
    rescue
      ConnectionError -> :error
    end
  end
end
