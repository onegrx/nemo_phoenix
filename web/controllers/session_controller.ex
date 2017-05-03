defmodule Nemo.SessionController do
  use Nemo.Web, :controller

  def new(conn, _params) do
    render conn, "new.html"
  end
end
