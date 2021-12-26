defmodule UnikeyWeb.KeysController do
  use UnikeyWeb, :controller

  alias Unikey.Key

  alias UnikeyWeb.FallbackController

  action_fallback FallbackController

  def create(conn, %{"bucket" => bucket_name}) do
    with {:ok, %Key{} = key} <- Unikey.create_key(bucket_name) do
      conn
      |> put_status(:created)
      |> render("create.json", key: key)
    end
  end
end
