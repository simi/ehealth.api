defmodule EHealth.Web.LegalEntityControllerTest do
  @moduledoc false

  use EHealth.Web.ConnCase

  @inactive_legal_entity_id "356b4182-f9ce-4eda-b6af-43d2de8602aa"

  test "create legal entity", %{conn: conn} do
    legal_entity_params = %{
      "signed_content_encoding" => "base64",
      "signed_legal_entity_request" => File.read!("test/data/signed_content.txt"),
    }

    conn = put conn, legal_entity_path(conn, :create_or_update), legal_entity_params
    resp = json_response(conn, 200)

    assert Map.has_key?(resp["data"], "id")
    assert "NOT_VERIFIED" == resp["data"]["status"]
    assert_security_in_urgent_response(resp)
    assert_urgent_field(resp, "employee_request_id")
  end

  test "invalid legal entity", %{conn: conn} do
    conn = put conn, legal_entity_path(conn, :create_or_update), %{"invlid" => "data"}
    resp = json_response(conn, 422)
    assert Map.has_key?(resp, "error")
    assert resp["error"]
  end

  test "get legal entities without x-consumer-metadata", %{conn: conn} do
    conn = get conn, legal_entity_path(conn, :index, [edrpou: "37367387"])
    resp = json_response(conn, 200)

    assert Map.has_key?(resp, "data")
    assert Map.has_key?(resp, "paging")
    assert is_list(resp["data"])
    assert 0 == length(resp["data"])
  end

  test "get legal entities with x-consumer-metadata that contains invalid client_id", %{conn: conn} do
    conn = put_client_id_header(conn, Ecto.UUID.generate())
    conn = get conn, legal_entity_path(conn, :index, [edrpou: "37367387"])
    resp = json_response(conn, 200)

    assert Map.has_key?(resp, "data")
    assert Map.has_key?(resp, "paging")
    assert is_list(resp["data"])
    assert 0 == length(resp["data"])
  end

  test "get legal entities with x-consumer-metadata that contains valid client_id", %{conn: conn} do
    conn = put_client_id_header(conn, "7cc91a5d-c02f-41e9-b571-1ea4f2375552")
    conn = get conn, legal_entity_path(conn, :index, [edrpou: "37367387"])
    resp = json_response(conn, 200)

    assert Map.has_key?(resp, "data")
    assert Map.has_key?(resp, "paging")
    assert is_list(resp["data"])
    assert 1 == length(resp["data"])
  end

  test "get legal entity by id without x-consumer-metadata", %{conn: conn} do
    id = "7cc91a5d-c02f-41e9-b571-1ea4f2375552"
    conn = get conn, legal_entity_path(conn, :show, id)
    json_response(conn, 404)
  end

  test "get legal entity by id with x-consumer-metadata that contains invalid client_id", %{conn: conn} do
    conn = put_client_id_header(conn, Ecto.UUID.generate())
    id = "7cc91a5d-c02f-41e9-b571-1ea4f2375552"
    conn = get conn, legal_entity_path(conn, :show, id)
    json_response(conn, 404)
  end

  test "get legal entity by id with x-consumer-metadata that contains valid client_id", %{conn: conn} do
    conn = put_client_id_header(conn, "7cc91a5d-c02f-41e9-b571-1ea4f2375552")
    id = "7cc91a5d-c02f-41e9-b571-1ea4f2375552"
    conn = get conn, legal_entity_path(conn, :show, id)
    resp = json_response(conn, 200)

    assert id == resp["data"]["id"]
    assert Map.has_key?(resp["data"], "medical_service_provider")
    refute Map.has_key?(resp, "paging")
    assert_security_in_urgent_response(resp)
  end

  test "get inactive legal entity by id", %{conn: conn} do
    conn = get conn, legal_entity_path(conn, :show, @inactive_legal_entity_id)
    assert 404 == json_response(conn, 404)["meta"]["code"]
  end

  def assert_security_in_urgent_response(resp) do
    assert_urgent_field(resp, "security")
    assert Map.has_key?(resp["urgent"]["security"], "redirect_uri")
    assert Map.has_key?(resp["urgent"]["security"], "client_id")
    assert Map.has_key?(resp["urgent"]["security"], "client_secret")
  end

  def assert_urgent_field(resp, field) do
    assert Map.has_key?(resp, "urgent")
    assert Map.has_key?(resp["urgent"], field)
  end
end
