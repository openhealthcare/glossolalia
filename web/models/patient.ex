defmodule Glossolalia.Patient do
  use Glossolalia.Web, :model

  schema "patients" do
    field :hospital_id, :string
    field :nhs_number, :string
    field :patient_surname, :string
    field :patient_forename, :string
    field :patient_title, :string
    field :date_of_birth, Ecto.Date
    has_many :comments, Glossolalia.Patient

    timestamps
  end

  @required_fields ~w(hospital_id nhs_number patient_surname patient_forename patient_title)
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
