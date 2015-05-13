defmodule GlossolaliaTest do
  use ExUnit.Case
  alias  Glossolalia.Encodings.HL7
  require  Glossolalia.Encodings.HL7

  @adt "PID|||PATID1234^5^M11||JONES^WILLIAM^A^III||19610615|M||C|1200 N ELM STREET^^GREENSBORO^NC^27401-1020|GL|(919)379-1212|(919)271-3434||S||PATID12345001^2^M10|123456789|987654^NC|\r"

  test "extract pid string" do
    msg = :ehl7.decode @adt
    name_etc = :ehl7.segment  :pid, msg

    assert HL7.personal_info(name_etc, :first_name) == "WILLIAM"
    assert HL7.personal_info(name_etc, :last_name)  == "JONES"
    assert HL7.personal_info(name_etc, :patient_id)  == "PATID1234"
  end


end
