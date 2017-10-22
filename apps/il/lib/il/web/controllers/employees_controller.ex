defmodule Il.Web.EmployeeController do
  @moduledoc false

  use Il.Web, :controller

  alias Scrivener.Page
  alias Il.Employee.API
  alias Il.Employee.EmployeeUpdater

  action_fallback Il.Web.FallbackController

  def index(conn, params) do
    with %Page{} = paging <- API.get_employees(params) do
      render(conn, "index.json", employees: paging.entries, paging: paging)
    end
  end

  def show(%Plug.Conn{req_headers: req_headers} = conn, %{"id" => id}) do
    with {:ok, employee} <- API.get_employee_by_id(id, req_headers) do
      render(conn, "employee.json", employee: employee)
    end
  end

  def deactivate(%Plug.Conn{req_headers: req_headers} = conn, params) do
    with {:ok, employee} <- EmployeeUpdater.deactivate(params, req_headers) do
      render(conn, "employee.json", employee: employee)
    end
  end
end
