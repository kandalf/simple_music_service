# Simple Music Service

This is a simple music service PoC that allows you to manage albums with their related artists and songs. It is built using Ruby On Rails 6.1 and a Postgres database

## Development environment setup

### Pre-requisites

To setup the development environment you'll need a working Ruby environment and git installed on your computer. The development of the project has been done using Ruby 3.0, but it should work with a recent previous version such as 2.7 as well. I would highly recommend using an isolated Ruby environment with the help of [rbenv](https://github.com/rbenv/rbenv), [RVM](http://rvm.io/) or any of your preference, just pick one and go with it.

You'll also need a database, preferrably Postgres, but it should work with any relational database that supports JSON data type, since some of the models includes attributes in JSON format.

### Setup

Once you have the pre-requisites, follow the next steps:

- `git clone https://github.com/kandalf/simple_music_service.git` Clone this repository
- `cd simple_music_service && bundle install` Move to the code directory and install dependencies
- `cp config/database.yml{.sample,}` Copy the sample database config file and edit it to add your databases configuration, for dev and test
- `rake db:create:all` Create the databases
- `rake test:all` Run the tests

If you got no errors or resolved the ones that raised, you should have a working development environment at this point. You can start your server with `bin/rails s`

### Reasoning behind the extra dependencies

Besides the Rails and Postgres required dependencies, the [Scrivener](https://github.com/soveran/scrivener) gem has been added for validation.
This might look redundant, but it is a small pure Ruby library and it allows to delegate the validation at controller level preventing hitting the database if the submitted data is not valid.

Validations at model level are also added so models can be used outside controllers (in a rake task, for example) and they validate the data going into the database as well.


## API Docs

Please check `docs/*.md` for endpoints documentation
