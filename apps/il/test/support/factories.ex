defmodule Il.Factories do
  @moduledoc false

  use ExMachina

  # PRM
  use Il.PRMFactories.LegalEntityFactory
  use Il.PRMFactories.MedicalServiceProviderFactory
  use Il.PRMFactories.GlobalParameterFactory
  use Il.PRMFactories.UkrMedRegistryFactory
  use Il.PRMFactories.DivisionFactory
  use Il.PRMFactories.EmployeeFactory
  use Il.PRMFactories.PartyFactory
  use Il.PRMFactories.MedicationFactory
  use Il.PRMFactories.MedicalProgramFactory

  # IL
  use Il.ILFactories.DictionaryFactory
  use Il.ILFactories.EmployeeRequestFactory
  use Il.ILFactories.DeclarationRequestFactory

  alias Il.Repo
  alias Il.PRMRepo

  def insert(type, factory, attrs \\ []) do
    factory
    |> build(attrs)
    |> repo_insert!(type)
  end

  defp repo_insert!(data, :il), do: Repo.insert!(data)
  defp repo_insert!(data, :prm), do: PRMRepo.insert!(data)
end
