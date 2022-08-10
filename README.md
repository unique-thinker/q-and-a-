## Installation

**Requirements:**

- **postgresql**
- **Ruby** 3.1.2
- **Rails** 7.0.3.1

##### 1. Clone the repository

```bash
git clone repository_url
```

##### 3. Run below command to generate credentials.yml.enc for development amd test enviroment

```bash
EDITOR="vim" rails credentials:edit --environment development
```

```bash
EDITOR="vim" rails credentials:edit --environment development
```

Paste the original credentials you copied from config/credentials/credentials.example.yml file in the new credentials file (and save + quit)

##### 4. Run bundler

```bash
bundle
```

##### 5. Create and setup the database

Run the following commands to create and setup the database.

```ruby
bundle exec rails db:create
bundle exec rails db:migrate
bundle exec rails db:seed
```

##### 6. Start the Rails server

You can start the rails server using the command given below.

```ruby
bundle exec rails s -p 3011
```

#### Production only
##### 4. Run bundler

```bash
bundle install --without development test
```
##### 5. Create and setup the database

Run the following commands to create and setup the database.

```ruby
RAILS_ENV=production bundle exec rails db:create
RAILS_ENV=production bundle exec rails db:migrate
RAILS_ENV=production bundle exec rails db:seed
```

##### 6. Start the Rails server

You can start the rails server using the command given below.

```ruby
RAILS_ENV=production bundle exec rails s
```
