# Nemo

## About

Nemo is the app which aims to boost your language memory speed. It consists of two parts:
 
 * Chrome extension to translating words
 * Nemo backend with staticstics and user management.
 

## Installing locally

Nemo uses PostgreSQL as a database, so make sure you have it installed.
To start Nemo app:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Furthermore, download Chrome Extension from this repository and load as unpacked extension having Developer mode turned on.
