defmodule Nemo.Model.UserTest do

  use Nemo.ModelCase

  alias Nemo.User

  test "user with valid fields is insertable" do
    params = build(:user_params)

    changeset = User.changeset(%User{}, params)

    assert changeset.valid?
    assert {:ok, _user} = Repo.insert(changeset)
  end

  test "user without valid fields is not insertable" do
    params = build(:user_params, email: nil)

    changeset = User.changeset(%User{}, params)

    refute changeset.valid?

    assert email: {"can't be blank", [validation: :required]} in
      changeset.errors

  end

end
