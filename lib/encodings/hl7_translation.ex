defmodule Glossolalia.Encodings.HL7_Translation do
  require HL7.Composite

  alias HL7.Segment.AUT
  alias HL7.Segment.MSA
  alias HL7.Segment.MSH
  alias HL7.Segment.PID
  alias HL7.Segment.PRD

  alias HL7.Composite.CE
  alias HL7.Composite.CM_MSH_9
  alias HL7.Composite.CP
  alias HL7.Composite.EI
  alias HL7.Composite.MO

  def patient(%{patient_name: name}) when is_map(name) do
    # surname = if is_map(name.family_name) do
    #             name.family_name.surname
    #           else
    #             "<unknown>"
    #           end
    # "Patient: #{name.given_name} #{surname}"
    name.family_name.surname
  end
  def patient(_pid) do
    nil
  end
end
