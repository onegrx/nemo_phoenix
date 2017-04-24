defmodule Nemo.PageController do
  use Nemo.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
