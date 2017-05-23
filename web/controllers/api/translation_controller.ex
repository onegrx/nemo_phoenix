defmodule Nemo.Api.TranslationController do
  use Nemo.Web, :controller

  alias Nemo.Repo
  alias Nemo.Word

  def index(conn, %{"token" => token,
                    "word" => word,
                    "translated" => translated}) do
    user =
      Repo.User.by_token(token)
      |> Repo.one()
    case user do
      nil -> conn
             |> json(%{"response" => "error"})
      user ->
        handle_translation(user, word, translated)
        conn
        |> json(%{"response" => "ok"})
    end
  end

  def index(conn, _params) do
    conn
    |> json(%{"response" => "not_valid_request"})
  end

  def handle_translation(user, word_string, translated) do
    require Logger
    word = Repo.Word.by_word(word_string)
           |> Repo.one
    case word do
      nil -> word_params = %{:word => word_string,
                             :translated => translated}
            word = %Word{}
                   |> Word.changeset(word_params)
                   |> Repo.insert!()
            put_assoc(user, word)

      word -> preloaded_word = Repo.preload(word, :users)
              maybe_insert(preloaded_word, user)
    end
  end

  defp maybe_insert(preloaded_word, user) do
    case user in preloaded_word.users do
      true -> :ok
      false -> put_assoc(user, preloaded_word)
    end
  end

  defp put_assoc(user, word) do
   %Nemo.UserWord{:user_id => user.id, :word_id => word.id}
   |> Nemo.UserWord.changeset()
   |> Repo.insert!
  end

end
