defmodule Nemo.Repo.Word do

  import Ecto.Query

  alias Nemo.Word

  @moduledoc """
  Module containting composable Ecto queries
  """

  @doc """
  Function return query for retriving `Nemo.Word` with given word
  """
  @spec by_word(Ecto.Queryable.t | Word.t, String.t) :: Ecto.Query.t
  def by_word(query \\ Word, word) do
    from t in query,
      where: t.word == ^word
  end

end
