defmodule XsslTest do
  use ExUnit.Case
  doctest Xssl

  test "greets the world" do
    assert Xssl.hello() == :world
  end
end
