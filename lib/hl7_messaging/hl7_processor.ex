defmodule Glossolalia.Hl7Messaging.Hl7Processor do
  require HL7.Composite
  alias Glossolalia.Patient 

  defp save_to_db(msg) do
    pid = HL7.segment(msg, "PID")

    # we get DOB as YYYYMMDD
    if !!pid.date_of_birth do
      dob = pid.date_of_birth
      d = %{
        :year => String.to_integer(String.slice(dob, 0, 4)),
        :month => String.to_integer(String.slice(dob, 4, 2)),
        :day => String.to_integer(String.slice(dob, 6, 2))
      }
      {:ok, date_of_birth} = Ecto.Date.cast(d)
    else
      date_of_birth = nil
    end

    Glossolalia.Repo.insert!(%Patient{
      date_of_birth: date_of_birth,
      hospital_id: pid.patient_id.id,
      patient_forename: pid.patient_name.given_name,
      patient_surname: pid.patient_name.family_name.surname,
    })
  end

  # def send_down_stream() do
  # end

  def process(msg) do
    save_to_db(msg)
  end
end
