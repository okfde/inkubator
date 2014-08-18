# Installation

- Clone the repository

$ git clone git@github.com:okfde/inkubator.git

- Copy and rename database.sample to database.yml
$ cp config/database.sample config/database.yml
- insert your DB specific parameters
- Create and Migrate Database

$ rake db:create
$ rake db:migrate

## in Development Environment

- create a new user by using the seeds
$ rake db:seed
- Create a .env file and add SEKRET_TOKEN to it. Do not commit this file!
$ SECRET_TOKEN=8rM4XYVaxTSS8K3Qoqf7pNVQ0CT3I3A7

