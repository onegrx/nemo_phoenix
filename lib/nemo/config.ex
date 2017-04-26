defmodule Nemo.Config do

  def get(key, default \\ :undefined) do
    config = Application.get_all_env(:nemo)
    get_value(key, config, default)
  end

  defp get_value([head | tail], config, default) do
    outer_val = get_value(head, config, default)
    get_value(tail, outer_val, default)
  end

  defp get_value([], config, _), do: config

  defp get_value(key, config, default) do
    Keyword.get(config, key, default)
  end

end
