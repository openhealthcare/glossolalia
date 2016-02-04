defmodule Glossolalia.PatientController do
  use Glossolalia.Web, :controller

  alias Glossolalia.Patient

  plug :scrub_params, "patient" when action in [:create, :update]

  def index(conn, _params) do
    patients = Repo.all(Patient)
    render(conn, "index.json", patients: patients)
  end

  def create(conn, %{"patient" => patient_params}) do
    changeset = Patient.changeset(%Patient{}, patient_params)

    # case Repo.insert(changeset) do
    #   {:ok, patient} ->
    #     conn
    #     |> put_status(:created)
    #     |> put_resp_header("location", patient_path(conn, :show, patient))
    #     |> render("show.json", patient: patient)
    #   {:error, changeset} ->
    #     conn
    #     |> put_status(:unprocessable_entity)
    #     |> render(Glossolalia.ChangesetView, "error.json", changeset: changeset)
    # end
  end

  def show(conn, %{"id" => id}) do
    patient = Repo.get!(Patient, id)
    render(conn, "show.json", patient: patient)
  end

  def update(conn, %{"id" => id, "patient" => patient_params}) do
    patient = Repo.get!(Patient, id)
    changeset = Patient.changeset(patient, patient_params)

    case Repo.update(changeset) do
      {:ok, patient} ->
        render(conn, "show.json", patient: patient)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Glossolalia.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    patient = Repo.get!(Patient, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(patient)

    send_resp(conn, :no_content, "")
  end
end
