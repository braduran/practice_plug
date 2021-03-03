### Consultar, crear, eliminar plug y ecto
Este pequeño proyecto consiste en consultar, crear y eliminar peliculas en una base de datos postgres a través de un api rest hecha con plug.
Plug nos ayuda a recibir y responder las peticiones y ecto es el driver que nos permite conectarnos a la base de datos.
A continuación el paso a paso para ejecutar este proyecto:


1. Ir a la carpeta *deployment* y ejecutar el docker compose:
```console
docker-compose up
```

2. Crear base de datos en postgres
3. Agregar dependencias con el comando:
```console
mix deps.get
```
4. Ir al archivo *config/dev.exs* y configurar la conexión de la base de datos:
```console
..
database: "Cine",
username: "admin",
password: "admin",
hostname: "localhost",
..
```

4. Crear la tabla movie através de un comando que nos facilita ecto
```console
mix ecto.migrate
```
En el punto 4 ecto toma la información de la carpeta *priv/repo/migrations* para crear la tabla

5. Correr la aplicación con alguno de los siguientes comandos:
```console 
iex -S mix
```
ó
```console
mix run --no-halt
```

6. Lanzar peticiones abriendo la colección de postman que se encuentra en la carpeta *deployment/movie.json*