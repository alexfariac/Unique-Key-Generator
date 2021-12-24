defmodule UnikeyWeb.Router do
  use UnikeyWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api/unikey", UnikeyWeb do
    pipe_through :api

    post "/buckets", BucketsController, :create
    get "/buckets/:bucket", BucketsController, :show

    post "/buckets/:bucket/sequence/next", BucketsController, :increase_sequence
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: UnikeyWeb.Telemetry
    end
  end
end
