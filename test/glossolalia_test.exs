defmodule GlossolaliaTest do
  use ExUnit.Case
  alias Glossolalia.Encodings.HL7_Translation
  require Glossolalia.Encodings.HL7_Translation
  require HL7.Composite

  # alias HL7.Segment.AUT
  # alias HL7.Segment.MSA
  # alias HL7.Segment.MSH
  alias HL7.Segment.PID
  # alias HL7.Segment.PRD
  #
  # alias HL7.Composite.CE
  # alias HL7.Composite.CM_MSH_9
  # alias HL7.Composite.CP
  # alias HL7.Composite.EI
  # alias HL7.Composite.MO

  def patient(%PID{patient_name: name}) when is_map(name) do
    surname = if is_map(name.family_name) do
                name.family_name.surname
              else
                "<unknown>"
              end
    "Patient: #{name.given_name} #{surname}"
  end
  def patient(_pid) do
    nil
  end

  test "extract pid string" do
    buf =
      "PID|||PATID1234^5^M11||JONES^WILLIAM^A^III||19610615|M||C|1200 N ELM STREET^^GREENSBORO^NC^27401-1020|GL|(919)379-1212|(919)271-3434||S||PATID12345001^2^M10|123456789|987654^NC|\r" <>
      "MSH|^~\\&|ADT1|MCM|LABADT|MCM|19880818112600|SECURITY|ADT^A01|MSG00001|P|2.3|\r" <>
      "EVN|A01|198808181123||<\r" <>
      "PID|||PATID1234^5^M11||JONES^WILLIAM^A^III||19610615|M||C|1200 N ELM STREET^^GREENSBORO^NC^27401-1020|GL|(919)379-1212|(919)271-3434||S||PATID12345001^2^M10|123456789|987654^NC|\r" <>
      "PV1|1|I|2000^2012^01||||004777^LEBAUER^SIDNEY^J.|||SUR||||ADM|A0|\r"

    {:ok, req} = HL7.read(buf, input_format: :wire)
    assert HL7.segment(req, "PID").patient_name.family_name.surname == "JONES"
    assert HL7.segment(req, "PID").patient_name.given_name == "WILLIAM"
    assert HL7.segment(req, "PID").patient_id.id == "PATID1234"
  end

  # test "extract header" do
    # msg = :ehl7.decode @msh
    # fields = :ehl7.segment :msh, msg
    #
    # {:ok, req} = newHL7.read(buf, input_format: :wire)
    # IO.puts "yo yo yo"
    #
    # assert HL7.message_header(fields, :message_control_id) == "MSG00001"
    # assert HL7.message_header(fields, :field_separator) == "|"
    # assert HL7.message_header(fields, :message_date) == {{1988, 8, 18}, {11, 26, 0}}
    # assert HL7.message_header(fields, :message_type) == "ADT"
    # assert HL7.message_header(fields, :trigger_event) == "A01"
  # end

  # test "patient visit" do
  #   msg = :ehl7.decode @pv
  #   fields = :ehl7.segment :pv1, msg
  #
  #   assert HL7.patient_visit(fields, :patient_class) == "I"
  #   assert HL7.patient_visit(fields, :patient_point_of_care) == "2000"
  #   assert HL7.patient_visit(fields, :attending_doctor_id) == "004777"
  #   assert HL7.patient_visit(fields, :attending_doctor_first_name) == "SIDNEY"
  #   assert HL7.patient_visit(fields, :attending_doctor_last_name) == "LEBAUER"
  #   assert HL7.patient_visit(fields, :referring_doctor_id) == :undefined
  #   assert HL7.patient_visit(fields, :referring_doctor_first_name) == :undefined
  #   assert HL7.patient_visit(fields, :referring_doctor_last_name) == :undefined
  #   assert HL7.patient_visit(fields, :readmission_indicator) == :undefined
  #   assert HL7.patient_visit(fields, :discharge_diposition) == :undefined
  #   assert HL7.patient_visit(fields, :admit_date) == :undefined
  #   assert HL7.patient_visit(fields, :discharge_date) == :undefined
  #   assert HL7.patient_visit(fields, :visit_indicator) == :undefined
  # end

  test "next of kin" do
    # next of kin is currently unsupported
    # msg = :ehl7.decode @nk
    # fields = :ehl7.segment :nk1, msg
  end

  test "extract event info" do
    # Error decoding date here.... calling
    #   src/ehl7_field.erl:104: :ehl7_field.from_raw_value("198808181123", :date, 14)
    # suspect it should be
    #   src/ehl7_field.erl:104: :ehl7_field.from_raw_value("198808181123", :date, 12)

    # msg = :ehl7.decode @evn
    # fields = :ehl7.segment :evn, msg
  end



end
