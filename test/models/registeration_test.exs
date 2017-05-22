defmodule Nemo.Model.RegisterationTest do

  use Nemo.ModelCase
  alias Nemo.User
  alias Nemo.Registration

  test "user is created and password hashed" do

    params = build(:user_params)
    changeset = User.changeset(%User{}, params)

    {:ok, user} = Registration.create(changeset, Nemo.Repo)

    username_length = String.length(user.username)

    assert user.id != nil
    assert user.email =~ "@"
    assert user.token != nil
    assert user.token =~ user.username <> "-"
    assert String.length(user.token) == username_length + 1 + 7

    user_db = Nemo.Repo.User.by_email(user.email) |> Repo.one

    assert Enum.count(User |> Repo.all) == 1
    assert user_db.username == "jasio"

  end


end
