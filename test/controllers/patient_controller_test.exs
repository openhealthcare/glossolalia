defmodule Glossolalia.PatientControllerTest do
  use Glossolalia.ConnCase

  alias Glossolalia.Patient
  @valid_attrs %{hospital_id: "some content", nhs_number: "some content", patient_forename: "some content", patient_surname: "some content", patient_title: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, patient_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    patient = Repo.insert! %Patient{}
    conn = get conn, patient_path(conn, :show, patient)
    assert json_response(conn, 200)["data"] == %{"id" => patient.id,
      "hospital_id" => patient.hospital_id,
      "nhs_number" => patient.nhs_number,
      "patient_surname" => patient.patient_surname,
      "patient_forename" => patient.patient_forename,
      "patient_title" => patient.patient_title}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, patient_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, patient_path(conn, :create), patient: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Patient, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, patient_path(conn, :create), patient: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    patient = Repo.insert! %Patient{}
    conn = put conn, patient_path(conn, :update, patient), patient: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Patient, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    patient = Repo.insert! %Patient{}
    conn = put conn, patient_path(conn, :update, patient), patient: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    patient = Repo.insert! %Patient{}
    conn = delete conn, patient_path(conn, :delete, patient)
    assert response(conn, 204)
    refute Repo.get(Patient, patient.id)
  end
end
