defmodule Glossolalia.PatientIdentifier do
  use Glossolalia.Web, :model

  use Ecto.Schema

  schema "patient_identifiers" do
    field :source, :string
    field :identifier, :string
    field :status, :string, default: "active"
    belongs_to :patient, Patient
    timestamps
  end

  @required_fields ~w(source identifier)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
