defmodule UnikeyWeb.KeysView do
  use UnikeyWeb, :view

  alias Unikey.Key

  def render("create.json", %{key: %Key{} = key}) do
    %{
      message: "Key Created!",
      key: key
    }
  end
end
