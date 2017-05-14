defmodule Nemo.Model.WordTest do

  use Nemo.ModelCase

  alias Nemo.Word

  test "word with valid fields is insertable" do
    params = build(:word_params)

    changeset = Word.changeset(%Word{}, params)

    assert changeset.valid?
    assert {:ok, _word} = Repo.insert(changeset)
  end

  test "word without valid fields is not insertable" do
    params = build(:user_params, word: nil)

    changeset = Word.changeset(%Word{}, params)

    refute changeset.valid?
    assert word: {"can't be blank", [validation: :required]} in
      changeset.errors
  end

end
