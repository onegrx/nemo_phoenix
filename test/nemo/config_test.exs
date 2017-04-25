defmodule Nemo.ConfigTest do
  use ExUnit.Case

  alias Nemo.Config

  setup_all do
    vars = [key1: :val1,
            key2: [nested_key1: :nested_val1,
                   nested_key2: :nested_val2]]
    vars
    |> Enum.each(fn ({key, val}) ->
      Application.put_env(:nemo, key, val)
    end
    )
  end

  test "Desired value could be retrived with module" do
    assert :val1 = Config.get :key1
    assert :val1 = Config.get :key1, :default
    assert :nested_val2 = Config.get [:key2, :nested_key2]
    assert :nested_val2 = Config.get [:key2, :nested_key2], :default
  end

  test ":undefined is returned for undefined variable" do
    assert :undefined = Config.get :non_existing
  end

  test "default value is returned for undefined variable" do
    assert :default = Config.get :non_existing, :default
  end

end
