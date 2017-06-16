defmodule Nemo.WordsController do
  use Nemo.Web, :controller

  alias Nemo.Repo

  def index(conn, _params) do
    id = Plug.Conn.get_session(conn, :current_user)
    if id do
      user = Repo.User.by_id(id)
      |> Repo.User.with_words
      |> Repo.one()
      render conn, "index.html", words: user.words
    else
      conn
      |> redirect(to: "/")
    end
  end

end
