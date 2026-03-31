defmodule SupportBannerTest do
  use ExUnit.Case
  doctest SupportBanner

  test "greets the world" do
    assert SupportBanner.hello() == :world
  end
end
