import Config

config :practice_movies,
       Movies.Repositories.Repo,
       database: "Cine",
       username: "admin",
       password: "admin",
       hostname: "localhost",
       show_sensitive_data_on_connection_error: true,
       pool_size: 10

config :practice_movies, ecto_repos: [Movies.Repositories.Repo]
