defmodule Glossolalia.PatientIdentifierControllerTest do
  use Glossolalia.ConnCase

  alias Glossolalia.PatientIdentifier
  @valid_attrs %{identifier: "some content", source: "some content", status: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, patient_identifier_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing patient identifiers"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, patient_identifier_path(conn, :new)
    assert html_response(conn, 200) =~ "New patient identifier"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, patient_identifier_path(conn, :create), patient_identifier: @valid_attrs
    assert redirected_to(conn) == patient_identifier_path(conn, :index)
    assert Repo.get_by(PatientIdentifier, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, patient_identifier_path(conn, :create), patient_identifier: @invalid_attrs
    assert html_response(conn, 200) =~ "New patient identifier"
  end

  test "shows chosen resource", %{conn: conn} do
    patient_identifier = Repo.insert! %PatientIdentifier{}
    conn = get conn, patient_identifier_path(conn, :show, patient_identifier)
    assert html_response(conn, 200) =~ "Show patient identifier"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, patient_identifier_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    patient_identifier = Repo.insert! %PatientIdentifier{}
    conn = get conn, patient_identifier_path(conn, :edit, patient_identifier)
    assert html_response(conn, 200) =~ "Edit patient identifier"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    patient_identifier = Repo.insert! %PatientIdentifier{}
    conn = put conn, patient_identifier_path(conn, :update, patient_identifier), patient_identifier: @valid_attrs
    assert redirected_to(conn) == patient_identifier_path(conn, :show, patient_identifier)
    assert Repo.get_by(PatientIdentifier, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    patient_identifier = Repo.insert! %PatientIdentifier{}
    conn = put conn, patient_identifier_path(conn, :update, patient_identifier), patient_identifier: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit patient identifier"
  end

  test "deletes chosen resource", %{conn: conn} do
    patient_identifier = Repo.insert! %PatientIdentifier{}
    conn = delete conn, patient_identifier_path(conn, :delete, patient_identifier)
    assert redirected_to(conn) == patient_identifier_path(conn, :index)
    refute Repo.get(PatientIdentifier, patient_identifier.id)
  end
end
