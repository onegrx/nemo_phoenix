defmodule Nemo.Repo.User do

  import Ecto.Query

  alias Nemo.User
  alias Nemo.Word

  @moduledoc """
  Module containting composable Ecto queries
  """

  @doc """
  Function return query for retriving `Nemo.User` with email address
  """
  @spec by_email(Ecto.Queryable.t | User.t, String.t) :: Ecto.Query.t
  def by_email(query \\ User, email) do
    from t in query,
      where: t.email == ^email
  end

  @doc """
  Function return query for retrivieng `Nemo.User` with preloaded and given
  amount of `Nemo.Word`'s
  """
  @spec with_words(Ecto.Queryable.t | User.t, integer) :: Ecto.Query.t
  def with_words(query \\ User, limit \\ 10) do
    words_query = from w in Word,
                    limit: ^limit
    from t in query,
      preload: [words: ^words_query]
  end

end