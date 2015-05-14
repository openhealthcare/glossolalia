defmodule HL7Bench do
  use Benchfella

  alias  Glossolalia.Encodings.HL7
  require  Glossolalia.Encodings.HL7

  @adt "PID|||PATID1234^5^M11||JONES^WILLIAM^A^III||19610615|M||C|1200 N ELM STREET^^GREENSBORO^NC^27401-1020|GL|(919)379-1212|(919)271-3434||S||PATID12345001^2^M10|123456789|987654^NC|\r"
  @msh "MSH|^~\\&|ADT1|MCM|LABADT|MCM|19880818112600|SECURITY|ADT^A01|MSG00001|P|2.3|\r\n"
  @evn "EVN|A01|198808181123||<\r"
  @pid "PID|||PATID1234^5^M11||JONES^WILLIAM^A^III||19610615|M||C|1200 N ELM STREET^^GREENSBORO^NC^27401-1020|GL|(919)379-1212|(919)271-3434||S||PATID12345001^2^M10|123456789|987654^NC|\r"
  @nk  "NK1|JONES^BARBARA^K|WIFE||||||NK^NEXT OF KIN<\r"
  @pv  "PV1|1|I|2000^2012^01||||004777^LEBAUER^SIDNEY^J.|||SUR||||ADM|A0|\r"

  bench "extract pid string" do
    msg = :ehl7.decode @pid
    name_etc = :ehl7.segment  :pid, msg

    _ = HL7.personal_info(name_etc, :first_name)
    _ = HL7.personal_info(name_etc, :last_name)
    _ = HL7.personal_info(name_etc, :patient_id)
  end

  bench "extract header" do
    msg = :ehl7.decode @msh
    fields = :ehl7.segment :msh, msg

    _ = HL7.message_header(fields, :message_control_id)
    _ = HL7.message_header(fields, :field_separator)
    _ = HL7.message_header(fields, :message_date)
    _ = HL7.message_header(fields, :message_type)
    _ = HL7.message_header(fields, :trigger_event)
  end

  bench "patient visit" do
    msg = :ehl7.decode @pv
    fields = :ehl7.segment :pv1, msg

    _ = HL7.patient_visit(fields, :patient_class)
    _ = HL7.patient_visit(fields, :patient_point_of_care)
    _ = HL7.patient_visit(fields, :attending_doctor_id)
    _ = HL7.patient_visit(fields, :attending_doctor_first_name)
    _ = HL7.patient_visit(fields, :attending_doctor_last_name)
    _ = HL7.patient_visit(fields, :referring_doctor_id)
    _ = HL7.patient_visit(fields, :referring_doctor_first_name)
    _ = HL7.patient_visit(fields, :referring_doctor_last_name)
    _ = HL7.patient_visit(fields, :readmission_indicator)
    _ = HL7.patient_visit(fields, :discharge_diposition)
    _ = HL7.patient_visit(fields, :admit_date)
    _ = HL7.patient_visit(fields, :discharge_date)
    _ = HL7.patient_visit(fields, :visit_indicator)
  end

end