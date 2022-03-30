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

#### Features
* Development
  - [annotate](https://github.com/ctran/annotate_models) - Annotate Rails classes with schema and routes info.
  - [awesome_print](https://github.com/awesome-print/awesome_print) - Pretty print your Ruby objects with style in full color and with proper indentation.
  - [faker](https://github.com/faker-ruby/faker) - A library for generating fake data such as names, addresses, and phone numbers.
  - (Comming Soon) [letter_opener_web](https://github.com/fgrehm/letter_opener_web) - A web interface for browsing Ruby on Rails sent emails.

* Security
  - (Comming Soon) [brakeman](https://github.com/presidentbeef/brakeman) - Detects security vulnerabilities in Ruby on Rails applications via static analysis.
  - (Comming Soon) [bundler-audi](https://github.com/rubysec/bundler-audit#readme) - Provides patch-level verification for Bundled apps.

* Authentication/Administration
  - (Comming Soon) [avo](https://github.com/avo-hq/avo) - Configuration-based, no-maintenance, extendable Ruby on Rails admin.
  - (Comming Soon) [devise](https://github.com/heartcombo/devise) - Flexible authentication solution for Rails with Warden.
  - (Comming Soon) [pretender](https://github.com/ankane/pretender) - Log in as another user in Rails.
  - (Comming Soon) [pundit](https://github.com/varvet/pundit) - Object oriented authorization for Rails applications.

* Job Processing
  - (Comming Soon) [good_job](https://github.com/bensheldon/good_job) - A multithreaded, Postgres-based ActiveJob backend for Ruby on Rails

* Other
  - (Comming Soon) [friendly_id](https://github.com/norman/friendly_id) - Create pretty URLs and work with human-friendly strings as if they were numeric ids.
  - (Comming Soon) [name_of_person](https://github.com/basecamp/name_of_person) - Presenting names of people in full, familiar, abbreviated, and initialized forms (but without titulation etc)
  - (Comming Soon) [sitemap_generator](https://github.com/kjvarga/sitemap_generator) - SitemapGenerator is a framework-agnostic XML Sitemap generator.
  - (Comming Soon) [inline_svg](https://github.com/jamesmartin/inline_svg) - Get an SVG into your view and then style it with CSS.
  - (Comming Soon) [responders](https://github.com/heartcombo/responders) - A set of Rails responders to dry up your application.

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
