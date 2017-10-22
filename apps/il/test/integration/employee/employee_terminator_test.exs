defmodule Il.Integration.EmployeeRequest.TerminatorTest do
  @moduledoc false

  use Il.Web.ConnCase

  alias Il.EmployeeRequest.Terminator
  alias Il.Employee.Request
  alias Il.Repo

  @tag :pending
  test "start init genserver" do
    employee_request = insert(:il, :employee_request)
    insert(:il, :employee_request)
    inserted_at = NaiveDateTime.add(NaiveDateTime.utc_now(), -86_400 * 10, :seconds)

    employee_request
    |> Ecto.Changeset.change(inserted_at: inserted_at)
    |> Repo.update()

    insert(:prm, :global_parameter, parameter: "employee_request_term_unit", value: "DAYS")
    insert(:prm, :global_parameter, parameter: "employee_request_expiration", value: "5")
    assert 2 = Request |> Repo.all() |> Enum.count

    GenServer.cast(Terminator, {:terminate, 1})
    Process.sleep(1000)

    expired_status = Request.status(:expired)
    assert %{status: ^expired_status} = Repo.get(Request, employee_request.id)
  end
end
