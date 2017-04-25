defmodule Nemo.Config do

  def get(key, default) do
    config = Application.get_all_env(:nemo)
    get_value(key, config, default)
  end

  def get(key) do
    config = Application.get_all_env(:nemo)
    get_value(key, config, :undefined)
  end

  defp get_value([head | tail], config, default) do
    outer_val = get_value(head, config, default)
    get_value(tail, outer_val, default)
  end

  defp get_value(_, config, _) when not is_list(config) do
    config
  end

  defp get_value(key, config, default) do
    case config do
      [] -> default
      _ ->
        case hd(config) do
          {^key, val} -> val
          _ -> get_value(key, tl(config), default)
        end
    end
  end

end
