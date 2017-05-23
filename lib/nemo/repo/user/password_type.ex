defmodule Nemo.User.PasswordType do

  @type t :: String.t

  alias Comeonin.Bcrypt

  @behaviour Ecto.Type

  def type, do: :string

  def cast(password) do
    hashed = Bcrypt.hashpwsalt(password)
    {:ok, hashed}
  end

  def dump(password), do: {:ok, password}

  def load(password), do: {:ok, password}

end
