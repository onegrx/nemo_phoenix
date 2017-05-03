defmodule Nemo.RegistrationController do
  use Nemo.Web, :controller
  alias Nemo.User

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render conn, changeset: changeset
  end
end
