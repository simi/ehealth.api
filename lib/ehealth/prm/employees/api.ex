defmodule EHealth.PRM.Employees do
  @moduledoc false

  alias EHealth.Repo
  alias EHealth.PRMRepo
  alias EHealth.PRM.Employees.Schema, as: Employee
  alias EHealth.PRM.Employees.Search
  alias Ecto.Multi
  use EHealth.PRM.Search

  @search_fields ~w(
    ids
    party_id
    legal_entity_id
    division_id
    status
    employee_type
    is_active
    tax_id
    edrpou
  )a

  @required_fields ~w(
    party_id
    legal_entity_id
    position
    status
    employee_type
    is_active
    inserted_by
    updated_by
    start_date
  )a

  @optional_fields ~w(
    division_id
    status_reason
    end_date
  )a

  def get_employee_by_id!(id) do
    Employee
    |> get_employee_by_id_query(id)
    |> PRMRepo.one!
  end

  def get_employee_by_id(id) do
    Employee
    |> get_employee_by_id_query(id)
    |> PRMRepo.one
  end

  defp get_employee_by_id_query(query, id) do
    query
    |> where([e], e.id == ^id)
    |> join(:left, [e], p in assoc(e, :party))
    |> join(:left, [e, p], d in assoc(e, :doctor))
    |> join(:left, [e], le in assoc(e, :legal_entity))
    |> preload([e, p, d, le], [party: p, doctor: d, legal_entity: le])
  end

  @doc """
  For internal use
  """
  def list(params) do
    Employee
    |> where([e], ^params)
    |> PRMRepo.all
  end

  def get_employees(params) do
    %Search{}
    |> changeset(params)
    |> search(params, Employee, Confex.get_env(:ehealth, :employees_per_page))
    |> preload_relations(params)
  end

  def update_all(query, updates) do
    Multi.new
    |> Multi.update_all(:employee_requests, query, set: updates)
    |> Repo.transaction
  end

  def create_employee(attrs, author_id) do
    %Employee{}
    |> changeset(attrs)
    |> PRMRepo.insert_and_log(author_id)
  end

  def update_employee(%Employee{} = employee, attrs, author_id) do
    employee
    |> changeset(attrs)
    |> PRMRepo.update_and_log(author_id)
  end

  def get_search_query(Employee = entity, %{ids: _} = changes) do
    super(entity, convert_comma_params_to_where_in_clause(changes, :ids, :id))
  end
  def get_search_query(Employee = entity, changes) do
    params =
      changes
      |> Map.drop([:tax_id, :edrpou])
      |> Map.to_list()

    entity
    |> query_tax_id(Map.get(changes, :tax_id))
    |> query_edrpou(Map.get(changes, :edrpou))
    |> where(^params)
  end

  defp changeset(%Search{} = employee, attrs) do
    cast(employee, attrs, @search_fields)
  end
  defp changeset(%Employee{} = employee, attrs) do
    employee
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> cast_assoc(:doctor)
    |> validate_required(@required_fields)
    |> validate_employee_type()
    |> foreign_key_constraint(:legal_entity_id)
    |> foreign_key_constraint(:division_id)
    |> foreign_key_constraint(:party_id)
  end

  defp validate_employee_type(%Ecto.Changeset{changes: %{employee_type: "DOCTOR"}} = changeset) do
    validate_required(changeset, [:doctor])
  end
  defp validate_employee_type(changeset), do: changeset

  def preload_relations({employees, %Ecto.Paging{} = paging}, params) when length(employees) > 0 do
    {preload_relations(employees, params), paging}
  end
  def preload_relations({:ok, employees}, params) do
    {:ok, preload_relations(employees, params)}
  end
  def preload_relations(repo, %{"expand" => _}) when length(repo) > 0 do
    do_preload(repo)
  end
  def preload_relations(err, _params), do: err

  defp do_preload(repo) do
    repo
    |> PRMRepo.preload(:doctor)
    |> PRMRepo.preload(:party)
    |> PRMRepo.preload(:division)
    |> PRMRepo.preload(:legal_entity)
  end

  def query_tax_id(query, nil), do: query
  def query_tax_id(query, tax_id) do
    query
    |> join(:left, [e], p in assoc(e, :party))
    |> where([..., p], p.tax_id == ^tax_id)
  end

  def query_edrpou(query, nil), do: query
  def query_edrpou(query, edrpou) do
    query
    |> join(:left, [e], le in assoc(e, :legal_entity))
    |> where([..., le], le.edrpou == ^edrpou)
  end

  defp convert_comma_params_to_where_in_clause(changes, param_name, db_field) do
    changes
    |> Map.put(db_field, {String.split(changes[param_name], ","), :in})
    |> Map.delete(param_name)
  end
end
