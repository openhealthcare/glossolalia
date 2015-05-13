defmodule Glossolalia.Encodings.HL7 do
  require Record

  Record.defrecord :message_header,   Record.extract(:msh,  from: "deps/ehl7/include/ehl7_segment.hrl")

  Record.defrecord :personal_info,    Record.extract(:pid,  from: "deps/ehl7/include/ehl7_segment.hrl")
  Record.defrecord :authorization_info, Record.extract(:aut, from: "deps/ehl7/include/ehl7_segment.hrl")
  Record.defrecord :diagnosis_info,   Record.extract(:dg1,  from: "deps/ehl7/include/ehl7_segment.hrl")
  Record.defrecord :continuation_ptr, Record.extract(:dsc,  from: "deps/ehl7/include/ehl7_segment.hrl")
  Record.defrecord :display_data,     Record.extract(:dsp,  from: "deps/ehl7/include/ehl7_segment.hrl")
  Record.defrecord :error_info,       Record.extract(:err,  from: "deps/ehl7/include/ehl7_segment.hrl")
  Record.defrecord :event_type,       Record.extract(:evn,  from: "deps/ehl7/include/ehl7_segment.hrl")
  Record.defrecord :insurance,        Record.extract(:in1,  from: "deps/ehl7/include/ehl7_segment.hrl")
  Record.defrecord :insurance_info,   Record.extract(:zin,  from: "deps/ehl7/include/ehl7_segment.hrl")
  Record.defrecord :message_ack,      Record.extract(:msa,  from: "deps/ehl7/include/ehl7_segment.hrl")
  Record.defrecord :notes,            Record.extract(:nte,  from: "deps/ehl7/include/ehl7_segment.hrl")
  Record.defrecord :procedure_info,   Record.extract(:pr1, from: "deps/ehl7/include/ehl7_segment.hrl")
  Record.defrecord :provider_info,    Record.extract(:prd,  from: "deps/ehl7/include/ehl7_segment.hrl")
  Record.defrecord :patient_visit,    Record.extract(:pv1,  from: "deps/ehl7/include/ehl7_segment.hrl")
  Record.defrecord :patient_visit_extra, Record.extract(:pv2,  from: "deps/ehl7/include/ehl7_segment.hrl")
  Record.defrecord :query_parameter,  Record.extract(:qpd_q15,  from: "deps/ehl7/include/ehl7_segment.hrl")
  Record.defrecord :query_ack,        Record.extract(:qak,  from: "deps/ehl7/include/ehl7_segment.hrl")
  Record.defrecord :response_control, Record.extract(:rcp,  from: "deps/ehl7/include/ehl7_segment.hrl")
  Record.defrecord :referral_info,    Record.extract(:rf1,  from: "deps/ehl7/include/ehl7_segment.hrl")
  Record.defrecord :procedure_authorization, Record.extract(:zau,  from: "deps/ehl7/include/ehl7_segment.hrl")


  @doc """
  Takes HL7 data && decodes it.
  """
  def decode(data) do
    :erlang.ehl7.decode data
  end

  @doc """
  Encodes data for HL7
  """
  def encode(data) do
    :erlang.ehl7.encode data
  end

end
