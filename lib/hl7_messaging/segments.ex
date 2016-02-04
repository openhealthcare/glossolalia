use HL7.Segment.Def


defmodule HL7.Segment.PD1 do
  segment "PD1" do
    field :gp_user_pointer,    seq:  1, type: :integer,  length:  4
    field :gp_surnanme,        seq:  2, type: :string,   length: 10
    field :gp_firstname,       seq:  3, type: :string,   length: 24
    field :gp_title,           seq:  4, type: :string,   length: 10
    field :gp_gmc,             seq:  5, type: :string,   length: 24
    field :practice_code,      seq:  6, type: :string,   length: 10
    field :practice_addr1,     seq:  7, type: :string,   length: 24
    field :practice_addr2,     seq:  8, type: :string,   length: 24
  end
end

defmodule HL7.Segment.NK1 do
  segment "NK1" do
  end
end

defmodule HL7.Segment.ZUK do
  segment "ZUK" do
    field :registration_comments,     seq:  50, type: :string,   length: 24
  end
end

# this is overriding an existing component but we need it...
# defmodule HL7.Segment.PID do
#   @moduledoc "3.4.2 PID - patient identification segment"
#   alias HL7.Composite.CX
#   alias HL7.Composite.XPN
#
#   segment "PID" do
#     field :set_id,                     seq:  1, type: :integer,  length:  4
#     field :patient_id,                 seq:  3, type: CX,        length: 48
#     field :alt_patient_id,             seq:  4, type: CX,        length: 48
#     field :patient_name,               seq:  5, type: XPN,       length: 51
#     field :date_of_birth,              seq:  7, type: :string,   length: 51
#   end
# end
