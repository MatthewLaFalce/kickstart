# Kickstart Rails Template

All your Rails apps should start off with a bunch of great defaults.

## Getting Started

Kickstart is a Rails template, so you pass it in as an option when creating a new app.

#### Requirements

You'll need the following installed to run the template successfully:

* Ruby 3.0 or higher
* bundler - `gem install bundler`
* rails - `gem install rails`
* Database - we recommend Postgres, but you can use MySQL, SQLite3, etc
* Redis - For ActionCable support
* Yarn - `brew install yarn` or [Install Yarn](https://yarnpkg.com/en/docs/install)
* Foreman (optional) - `gem install foreman` - helps run all your processes in development

#### Creating a new app

```bash
rails new myapp --database=postgresql --css=tailwind --skip-bundle --skip-test -m https://raw.githubusercontent.com/MatthewLaFalce/kickstart/main/template.rb
```

Or if you have downloaded this repo, you can reference template.rb locally:

```bash
rails new myapp --database=postgresql --css=tailwind --skip-bundle --skip-test -m template.rb
```

❓Having trouble? Try adding `DISABLE_SPRING=1` before `rails new`. Spring will get confused if you create an app with the same name twice.

#### Running your app

```bash
bin/dev
```

You can also run them in separate terminals manually if you prefer.

A separate `Procfile` is generated for deploying to production on Heroku.

#### Redis set up
##### On OSX
```
brew update
brew install redis
brew services start redis
```
##### Ubuntu
```
sudo apt-get install redis-server
```

#### Cleaning up

```bash
rails db:drop
spring stop
cd ..
rm -rf myapp
```
