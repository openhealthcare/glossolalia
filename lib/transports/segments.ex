use HL7.Segment.Def

defmodule HL7.Segment.PD1 do
  alias HL7.Composite.CE

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
