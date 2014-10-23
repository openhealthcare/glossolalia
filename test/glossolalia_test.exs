defmodule GlossolaliaTest do
  use ExUnit.Case

  test "the truth" do
    assert(true)
  end

  test "can I do it" do
    assert Glossolalia.Accepter.service_exists?(:OPAL, :elcid)
  end


end
