defmodule EHealth.Divisions.Search do
  @moduledoc false

  use Ecto.Schema

  @primary_key false
  schema "division_search" do
    field :ids, EHealth.Ecto.CommaParamsUUID
    field :name, :string
    field :type, :string
    field :status, :string
    field :legal_entity_id, Ecto.UUID
    field :lefttop_latitude, :float
    field :lefttop_longitude, :float
    field :rightbottom_latitude, :float
    field :rightbottom_longitude, :float
  end
end
