defmodule Nemo.Router do
  use Nemo.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Nemo do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

    resources "/registrations", RegistrationController, only: [:new, :create]

    get    "/login",  SessionController, :new
    post   "/login",  SessionController, :create
    delete "/logout", SessionController, :delete
    get    "/words",  WordsController,   :index
    get    "/account",AccountController, :index

  end

   scope "/api", Nemo.Api do
     pipe_through :api
     get "/stats", TranslationController, :index
   end
end
