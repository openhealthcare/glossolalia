defmodule Glossolalia.PatientTest do
  use Glossolalia.ModelCase

  alias Glossolalia.Patient

  @valid_attrs %{hospital_id: "some content", nhs_number: "some content", patient_forename: "some content", patient_surname: "some content", patient_title: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Patient.changeset(%Patient{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Patient.changeset(%Patient{}, @invalid_attrs)
    refute changeset.valid?
  end
end
