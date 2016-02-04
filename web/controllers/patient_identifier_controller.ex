defmodule Glossolalia.PatientIdentifierController do
  use Glossolalia.Web, :controller

  alias Glossolalia.PatientIdentifier

  plug :scrub_params, "patient_identifier" when action in [:create, :update]

  def index(conn, _params) do
    patient_identifiers = Repo.all(PatientIdentifier)
    render(conn, "index.html", patient_identifiers: patient_identifiers)
  end

  def new(conn, _params) do
    changeset = PatientIdentifier.changeset(%PatientIdentifier{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"patient_identifier" => patient_identifier_params}) do
    changeset = PatientIdentifier.changeset(%PatientIdentifier{}, patient_identifier_params)

    case Repo.insert(changeset) do
      {:ok, _patient_identifier} ->
        conn
        |> put_flash(:info, "Patient identifier created successfully.")
        |> redirect(to: patient_identifier_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    patient_identifier = Repo.get!(PatientIdentifier, id)
    render(conn, "show.html", patient_identifier: patient_identifier)
  end

  def edit(conn, %{"id" => id}) do
    patient_identifier = Repo.get!(PatientIdentifier, id)
    changeset = PatientIdentifier.changeset(patient_identifier)
    render(conn, "edit.html", patient_identifier: patient_identifier, changeset: changeset)
  end

  def update(conn, %{"id" => id, "patient_identifier" => patient_identifier_params}) do
    patient_identifier = Repo.get!(PatientIdentifier, id)
    changeset = PatientIdentifier.changeset(patient_identifier, patient_identifier_params)

    case Repo.update(changeset) do
      {:ok, patient_identifier} ->
        conn
        |> put_flash(:info, "Patient identifier updated successfully.")
        |> redirect(to: patient_identifier_path(conn, :show, patient_identifier))
      {:error, changeset} ->
        render(conn, "edit.html", patient_identifier: patient_identifier, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    patient_identifier = Repo.get!(PatientIdentifier, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(patient_identifier)

    conn
    |> put_flash(:info, "Patient identifier deleted successfully.")
    |> redirect(to: patient_identifier_path(conn, :index))
  end
end
