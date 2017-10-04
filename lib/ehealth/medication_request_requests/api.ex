defmodule EHealth.MedicationRequestRequests do
  @moduledoc """
  The MedicationRequestRequests context.
  """

  import Ecto.Query, warn: false
  import Ecto.Changeset
  alias EHealth.Repo

  use Confex, otp_app: :ehealth

  alias EHealth.MedicationRequestRequest
  alias EHealth.MedicationRequestRequest.Validations
  alias EHealth.MedicationRequestRequest.DataMapper

  @doc """
  Returns the list of medication_request_requests.

  ## Examples

      iex> list_medication_request_requests()
      [%MedicationRequestRequest{}, ...]

  """
  def list_medication_request_requests do
    Repo.all(MedicationRequestRequest)
  end

  def list_medication_request_requests(params) do
    query = from dr in MedicationRequestRequest,
    order_by: [desc: :inserted_at]

    page_params = Map.merge(%{
      page_size: Confex.fetch_env!(:ehealth, :declaration_requests_per_page)
    }, params)

    query
    |> filter_by_employee_id(params)
    |> filter_by_legal_entity_id(params)
    |> filter_by_status(params)
    |> Repo.paginate(page_params)
  end

  defp filter_by_legal_entity_id(query, %{"legal_entity_id" => legal_entity_id}) do
    where(query, [r], fragment("?->'legal_entity_id' = ?", r.data, ^legal_entity_id))
  end
  defp filter_by_legal_entity_id(query, _), do: query

  defp filter_by_employee_id(query, %{"employee_id" => employee_id}) do
    where(query, [r], fragment("?->'employee_id' = ?", r.data, ^employee_id))
  end
  defp filter_by_employee_id(query, _), do: query

  defp filter_by_status(query, %{"status" => status}) when is_binary(status) do
    where(query, [r], r.status == ^status)
  end
  defp filter_by_status(query, _), do: query

  @doc """
  Gets a single medication_request_request.

  Raises `Ecto.NoResultsError` if the Medication request request does not exist.

  ## Examples

      iex> get_medication_request_request!(123)
      %MedicationRequestRequest{}

      iex> get_medication_request_request!(456)
      ** (Ecto.NoResultsError)

  """
  def get_medication_request_request!(id), do: Repo.get!(MedicationRequestRequest, id)

  @doc """
  Creates a medication_request_request.

  ## Examples

      iex> create(%{field: value})
      {:ok, %MedicationRequestRequest{}}

      iex> create(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create(attrs, user_id, client_id) do
    with :ok <- Validations.validate_schema(attrs)
    do
      %MedicationRequestRequest{}
      |> create_changeset(attrs, user_id, client_id)
      |> Repo.insert()
    else
      err -> err
    end
  end

  @doc false
  def create_changeset(%MedicationRequestRequest{} = medication_request_request, attrs, user_id, client_id) do
    medication_request_request
    |> cast(attrs, [:number, :status, :inserted_by, :updated_by])
    |> DataMapper.map_data(attrs, client_id)
    |> put_change(:status, "NEW")
    |> put_change(:number, "TEST")
    |> put_change(:inserted_by, user_id)
    |> put_change(:updated_by, user_id)
    |> validate_required([:data, :number, :status, :inserted_by, :updated_by])
  end

  def changeset(%MedicationRequestRequest{} = medication_request_request, attrs) do
    medication_request_request
    |> cast(attrs, [:data, :number, :status, :inserted_by, :updated_by])
    |> validate_required([:data, :number, :status, :inserted_by, :updated_by])
  end
end