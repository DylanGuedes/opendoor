# OpenDoor

OpenDoor is a platform to manage data gathering to feed a InterSCity platform
instance.

# Setup

1. Install Ruby (we are currently using '2.3.1')
2. Install Redis (for Sidekiq)
3. Install Sidekiq
4. Install Postgres
5. Install the gems that we use (`bundle install` inside the project folder)
6. Create the database: `rake db:create`
7. Run migrations: `rake db:migrate`
8. Run sidekiq: `sidekiq` (inside project folder)
9. Run the server: `rails server`

# Running tests

We use mainly `rspec` to write the tests. You just need to execute `rspec`
after installing the gems.
