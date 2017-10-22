defmodule Il.Man.Templates.EmployeeCreatedNotification do
  @moduledoc false

  use Confex, otp_app: :il

  alias Il.Man.Templates.EmployeeRequestInvitation
  alias Il.API.Man
  alias Il.Employee.Request
  alias Il.PRM.LegalEntities

  def render(%Request{id: id, data: data}) do
    clinic_info =
      data
      |> Map.get("legal_entity_id")
      |> LegalEntities.get_legal_entity_by_id()
      |> EmployeeRequestInvitation.get_clinic_info()

    template_data = %{
       format: config()[:format],
       locale: config()[:locale],
       date: EmployeeRequestInvitation.current_date("Europe/Kiev", "%d.%m.%y"),
       clinic_name: Map.get(clinic_info, :name),
       clinic_address: Map.get(clinic_info, :address),
       doctor_role: Map.get(data, "position"),
       request_id: id
     }
     template_id = config()[:id]

    Man.render_template(template_id, template_data)
  end
end
