defmodule Il.PRM.MedicalPrograms.Search do
  @moduledoc false

  use Ecto.Schema

  @primary_key false
  schema "medical_programs_search" do
    field :id, Ecto.UUID
    field :name, Il.Ecto.StringLike
    field :is_active, :boolean
  end
end
