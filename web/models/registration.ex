defmodule Nemo.Registration do
  import Ecto.Changeset, only: [put_change: 3]

  def create(changeset, repo) do
    changeset
    |> put_change(:password, hashed_password(changeset.params["password"]))
    |> put_change(:token, generate_unique_token(changeset.params["username"]))
    |> repo.insert()
  end

  defp hashed_password(password) do
    Comeonin.Bcrypt.hashpwsalt(password)
  end

  defp generate_unique_token(username, length \\ 7) do
    token = :crypto.strong_rand_bytes(length)
      |> Base.url_encode64
      |> binary_part(0, length)
    username <> "-" <> token
  end
end
