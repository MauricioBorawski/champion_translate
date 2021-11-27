defmodule ChampionTest do
  use ExUnit.Case
  doctest Champion

  test "greets the world" do
    assert Champion.hello() == :world
  end
end
