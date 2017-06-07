defmodule Nemo.Repo.User do

  import Ecto.Query

  alias Nemo.User
  alias Nemo.Word

  @typep limit_with_infinity :: integer | :infinity
  @typep queryable :: queryable

  @moduledoc """
  Module containting composable Ecto queries
  """

  @spec by_id(queryable, String.t) :: Ecto.Query.t
  def by_id(query \\ User, id) do
    from t in query,
      where: t.id == ^id
  end

  @doc """
  Function return query for retriving `Nemo.User` with email address
  """
  @spec by_email(queryable, String.t) :: Ecto.Query.t
  def by_email(query \\ User, email) do
    from t in query,
      where: t.email == ^email
  end

  @doc """
  Function return query for retriving `Nemo.User` with token
  """
  @spec by_token(queryable, String.t) :: Ecto.Query.t
  def by_token(query \\ User, token) do
    from t in query,
      where: t.token == ^token
  end

  @doc """
  Function return query for retrivieng `Nemo.User` with preloaded and given
  amount of `Nemo.Word`'s
  """
  @spec with_words(queryable, limit_with_infinity) :: Ecto.Query.t
  def with_words(query \\ User, limit \\ 10) do
    words_query = get_words_query(limit)
    from t in query,
      preload: [words: ^words_query]
  end

  defp get_words_query(:infinity), do: from w in Word
  defp get_words_query(limit),     do: from w in Word, limit: ^limit

end
