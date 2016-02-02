defmodule Glossolalia.Hl7Messaging.Hl7ProcessorTest do
  use ExUnit.Case
  alias Glossolalia.Transports.Hl7.Job
  alias Glossolalia.Transports.Mllp.Serializer
  use Glossolalia.ModelCase

  test "save patient" do

    buf =
      "PID|||PATID1234^5^M11||JONES^WILLIAM^A^III||19610615|M||C|1200 N ELM STREET^^GREENSBORO^NC^27401-1020|GL|(919)379-1212|(919)271-3434||S||PATID12345001^2^M10|123456789|987654^NC|\r" <>
      "MSH|^~\\&|ADT1|MCM|LABADT|MCM|19880818112600|SECURITY|ADT^A01|MSG00001|P|2.3|\r" <>
      "EVN|A01|198808181123||<\r" <>
      "PID|||PATID1234^5^M11||JONES^WILLIAM^A^III||19610615|M||C|1200 N ELM STREET^^GREENSBORO^NC^27401-1020|GL|(919)379-1212|(919)271-3434||S||PATID12345001^2^M10|123456789|987654^NC|\r" <>
      "PV1|1|I|2000^2012^01||||004777^LEBAUER^SIDNEY^J.|||SUR||||ADM|A0|\r"


    req = Serializer.decode!(buf)
    Job.process(req)
    query = from p in Patient,
          where: p.patient_forename == "JONES",
         select: p.patient_forename
    result = Glossolalia.Repo.all(query)
    assert result == "WILLIAM"
  end
end