defmodule Glossolalia.PatientIdentifierTest do
  use Glossolalia.ModelCase

  alias Glossolalia.PatientIdentifier

  @valid_attrs %{identifier: "some content", source: "some content", status: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = PatientIdentifier.changeset(%PatientIdentifier{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = PatientIdentifier.changeset(%PatientIdentifier{}, @invalid_attrs)
    refute changeset.valid?
  end
end
