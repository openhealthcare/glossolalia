defmodule Glossolalia.PatientView do
  use Glossolalia.Web, :view

  def render("index.json", %{patients: patients}) do
    %{data: render_many(patients, Glossolalia.PatientView, "patient.json")}
  end

  def render("show.json", %{patient: patient}) do
    %{data: render_one(patient, Glossolalia.PatientView, "patient.json")}
  end

  def render("patient.json", %{patient: patient}) do
    %{id: patient.id,
      hospital_id: patient.hospital_id,
      nhs_number: patient.nhs_number,
      patient_surname: patient.patient_surname,
      patient_forename: patient.patient_forename,
      patient_title: patient.patient_title}
  end
end
