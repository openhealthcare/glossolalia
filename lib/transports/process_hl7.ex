alias Glossolalia.Transports.Mllp.Serializer

alias HL7.Segment.MSA
alias HL7.Segment.MSH
alias HL7.Composite.CM_MSH_9

defmodule Glossolalia.Transports.Hl7.Processor do

  def get_msh(msh) do
      %MSH{msh |
                  sending_app: msh.receiving_app,
                  sending_facility: msh.receiving_facility,
                  receiving_app: msh.sending_app,
                  receiving_facility: msh.sending_facility,
                  message_datetime: :calendar.universal_time(),
                  # RPA^I08
                  # TODO this may not be right
                  message_type: %CM_MSH_9{msh.message_type | id: "RPA"},
                  # Kids, don't try this at home
                  message_control_id: Base.encode32(:crypto.rand_bytes(5)),
                  accept_ack_type: "AL",
                  app_ack_type: "NE"
                }
  end

  def get_msa(msh) do
    %MSA{
        ack_code: "AA",
        message_control_id: msh.message_control_id
      }
  end

  def process_message(msg) do
    req = Serializer.decode!(msg)
    msh = HL7.segment(req, "MSH")
    res = HL7.replace(req, "MSH", get_msh(msh))
    res = HL7.insert_after(res, "MSH", get_msa(msh))
    HL7.write(res, output_format: :wire, trim: true)
  end
end
