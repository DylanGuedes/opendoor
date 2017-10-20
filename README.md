# OpenDoor

OpenDoor is a platform to manage data gathering to feed a InterSCity platform
instance.

# Setup

**Via docker**

1. Install docker and docker-compose
2. Clone this repository
3. Run containers: `docker-compose up -d`
4. Create database and run migrations: `docker-compose run opendoor rake
   db:create` and `docker-compose run opendoor rake db:migrate`
5. Visit the dashboard at `localhost:3001`

**Without Docker**

1. Install Ruby (we are currently using '2.3.1')
2. Install Redis (for Sidekiq)
3. Install Sidekiq
4. Install Postgres
5. Install the gems that we use (`bundle install` inside the project folder)
6. Configure the database host at `config/database.yml`
7. Set your redis instance at `config/initializers/sidekiq.rb`
8. Create the database: `rake db:create`
9. Run migrations: `rake db:migrate`
10. Run sidekiq: `sidekiq` (inside project folder)
11. Run the server: `rails server`

# Running tests

We use mainly `rspec` to write the tests. To run the tests, run `rspec`
after installing the gems.
