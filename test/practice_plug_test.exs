defmodule PracticePlugTest do
  use ExUnit.Case
  doctest PracticePlug

  test "greets the world" do
    assert PracticePlug.hello() == :world
  end
end
