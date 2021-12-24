defmodule UnikeyWeb.BucketsController do
  use UnikeyWeb, :controller

  alias Unikey.Bucket

  alias UnikeyWeb.FallbackController

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, %Bucket{} = bucket} <- Unikey.create_bucket(params) do
      conn
      |> put_status(:created)
      |> render("create.json", bucket: bucket)
    end
  end

  def show(conn, %{"bucket" => bucket_name}) do
    with {:ok, %Bucket{} = bucket} <- Unikey.get_bucket(bucket_name) do
      conn
      |> put_status(:ok)
      |> render("show.json", bucket: bucket)
    end
  end

  def increase_sequence(conn, %{"bucket" => bucket_name}) do
    with {:ok, %Bucket{random_offset: random_offset}} <- Unikey.get_bucket(bucket_name),
         offset = get_offset(random_offset),
         {:ok, sequence} <- Unikey.increase_sequence(bucket_name, offset) do
      conn
      |> put_status(:ok)
      |> render("increase_sequence.json", sequence: sequence)
    end
  end

  defp get_offset(true), do: :rand.uniform(16)
  defp get_offset(random_offset) when random_offset == false, do: 1
end
