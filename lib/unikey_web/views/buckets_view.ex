defmodule UnikeyWeb.BucketsView do
  use UnikeyWeb, :view

  def render("create.json", %{bucket: bucket}) do
    %{
      message: "Bucket Created!",
      bucket: bucket
    }
  end

  def render("show.json", %{bucket: bucket}), do: bucket

  def render("increase_sequence.json", %{sequence: sequence}) do
    %{
      sequence: sequence
    }
  end
end
