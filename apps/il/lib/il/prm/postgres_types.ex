# Enable PostGIS for Ecto
Postgrex.Types.define(
  Il.PRM.PostgresTypes,
  [Geo.PostGIS.Extension] ++ Ecto.Adapters.Postgres.extensions(),
  json: Poison
)
