defmodule Il.PRM.Medications.INNMDosage.Search do
  @moduledoc false

  use Ecto.Schema

  alias Il.Ecto.StringLike

  @primary_key false
  schema "innm_dosage_search" do
    field :id, Ecto.UUID
    field :name, StringLike
    field :form, :string
    field :type, :string
    field :is_active, :boolean
  end
end
