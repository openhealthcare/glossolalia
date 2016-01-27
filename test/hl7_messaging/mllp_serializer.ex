defmodule Glossolalia.Hl7Messaging.MllpSerializer Test do
  use ExUnit.Case
  alias Glossolalia.Transports.Mllp.Serializer

  test "extract pid string" do
    buf =
      "PID|||PATID1234^5^M11||JONES^WILLIAM^A^III||19610615|M||C|1200 N ELM STREET^^GREENSBORO^NC^27401-1020|GL|(919)379-1212|(919)271-3434||S||PATID12345001^2^M10|123456789|987654^NC|\r" <>
      "MSH|^~\\&|ADT1|MCM|LABADT|MCM|19880818112600|SECURITY|ADT^A01|MSG00001|P|2.3|\r" <>
      "EVN|A01|198808181123||<\r" <>
      "PID|||PATID1234^5^M11||JONES^WILLIAM^A^III||19610615|M||C|1200 N ELM STREET^^GREENSBORO^NC^27401-1020|GL|(919)379-1212|(919)271-3434||S||PATID12345001^2^M10|123456789|987654^NC|\r" <>
      "PV1|1|I|2000^2012^01||||004777^LEBAUER^SIDNEY^J.|||SUR||||ADM|A0|\r"

    req = Serializer.decode!(buf)
    assert HL7.segment(req, "PID").patient_name.family_name.surname == "JONES"
    assert HL7.segment(req, "PID").patient_name.given_name == "WILLIAM"
    assert HL7.segment(req, "PID").patient_id.id == "PATID1234"
  end


end
