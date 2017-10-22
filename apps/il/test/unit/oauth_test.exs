defmodule Il.Unit.OAuthAPITest do
  @moduledoc false

  use ExUnit.Case

  alias Ecto.UUID
  alias Il.OAuth.API
  alias Il.PRM.LegalEntities.Schema, as: LegalEntity

  test "check client name for client creation" do
    name = "my name"
    client = %LegalEntity{
      id: UUID.generate(),
      name: name
    }
    assert {:ok, %{"data" => resp}} = API.put_client(client, "example.com", Ecto.UUID.generate(), [])
    assert name == resp["name"]
  end
end
