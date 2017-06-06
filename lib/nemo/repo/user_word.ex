defmodule Nemo.Repo.UserWord do

  import Ecto.Query

  alias Nemo.UserWord

  @moduledoc """
  Module containting composable Ecto queries
  """

  @doc """
  Function return relation for given `Nemo.User` id and `Nemo.Word` id
  """
  @spec by_ids(Ecto.Queryable.t | UserWord.t, integer, integer)
        :: Ecto.Query.t
  def by_ids(query \\ UserWord, user_id, word_id) do
    from t in query,
      where: t.user_id == ^user_id,
      where: t.word_id == ^word_id
  end

end
