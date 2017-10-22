defmodule Il.PRM.Medications.Program.Schema do
  @moduledoc false
  use Ecto.Schema
  alias Il.PRM.Medications.Medication.Schema, as: Medication
  alias Il.PRM.MedicalPrograms.Schema, as: MedicalProgram

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "program_medications" do
    field :reimbursement, :map
    field :medication_request_allowed, :boolean, default: true
    field :is_active, :boolean, default: true
    field :inserted_by, Ecto.UUID
    field :updated_by, Ecto.UUID

    belongs_to :medication, Medication, type: Ecto.UUID
    belongs_to :medical_program, MedicalProgram, type: Ecto.UUID

    timestamps()
  end
end
