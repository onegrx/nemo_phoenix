defmodule Nemo.Api.TranslationController do
  use Nemo.Web, :controller

  alias Nemo.Repo
  alias Nemo.Word
  alias Nemo.UserWord

  def index(conn, %{"token" => token,
                    "word" => word,
                    "translated" => translated}) do
    user = Repo.User.by_token(token) |> Repo.one()
    case user do
      nil ->
        conn
        |> put_status(401)
        |> json(%{"response" => "error"})
      user ->
        handle_translation(user, word, translated)
        conn
        |> put_status(200)
        |> json(%{"response" => "ok"})
    end
  end

  def index(conn, _params) do
    conn
    |> put_status(500)
    |> json(%{"response" => "not_valid_request"})
  end

  @spec handle_translation(User.t, String.t, String.t) :: UserWord.t
  def handle_translation(user, word_string, translated) do
    require Logger
    word = Repo.Word.by_word(word_string)
           |> Repo.one
           |> maybe_insert_word(word_string, translated)
    update_uses(user, word)
  end

  @spec maybe_insert_word(Word.t | nil, String.t, String.t) :: Word.t
  defp maybe_insert_word(nil, word_string, translated) do
    %Word{}
    |> Word.changeset(%{:word => word_string, :translated => translated})
    |> Repo.insert!()
  end

  defp maybe_insert_word(word, _word_string, _translated), do: word

  @spec update_uses(User.t, Word.t) :: UserWord.t
  defp update_uses(user, word) do
    case get_user_word_relation(user, word) do
      nil ->
        %UserWord{}
        |> Repo.preload([:user, :word])
        |> UserWord.changeset(%{user: user, word: word, uses: 1})
        |> Repo.insert!()
      user_word ->
        user_word
        |> UserWord.changeset(%{uses: user_word.uses + 1})
        |> Repo.update!()
      end
  end

  @spec get_user_word_relation(User.t, Word.t) :: UserWord.t
  defp get_user_word_relation(user, word) do
    Repo.UserWord.by_ids(user.id, word.id)
    |> Repo.one
  end

end
