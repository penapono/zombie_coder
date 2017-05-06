# Zombie Coder

## Configuration

### Ruby version
  - 2.4.0

### Rails version
  - 5.0.2

### Starting
  - Using RVM

  ```bash
  rvm install 2.4.0
  rvm use 2.4.0
  rvm 2.4.0 do gem install bundler
  bundle install
  ```

### Database

  ```YAML
  default: &default
    adapter: sqlite3
    pool: 5
    timeout: 5000

  development:
    <<: *default
    database: db/development.sqlite3

  test:
    <<: *default
    database: db/test.sqlite3

  production:
    <<: *default
    database: db/production.sqlite3
  ```

### Database creation
  - Database init

  ```bash
  rake db:create db:migrate
  ```

### Start API

```bash
rails s
```

### Testing

- Starts guard, a sentinel watching modified files and running `_spec` files automaticaly

```bash
guard
```

## Using API

### Survivors

#### Marking survivor as infected!

POST  /api/v1/survivors/:id/flag_infected

Parameters:

params[:id] # survivor ID

---

#### Trading items

POST  /api/v1/survivors/:id/trade

Parameters:

params[:id]         # Survivor
trade_from[:items]  # Items to give to Survivor
trade_to[:id]       # Survivor to trade with
trade_to[:items]    # Items to get from Survivor

#### Listing non-infected survivors!

GET   /api/v1/survivors

Response example:

[{"id":4,"name":"Pedro","age":22,"gender":0,"latitude":"10","longitude":"20","items":[{"id":1,"name":"water","ammount":1,"points":4,"survivor_id":4},{"id":2,"name":"food","ammount":1,"points":3,"survivor_id":4},{"id":3,"name":"medication","ammount":1,"points":2,"survivor_id":4},{"id":4,"name":"ammunition","ammount":1,"points":1,"survivor_id":4}]}]

---

#### Creating a new survivor

POST  /api/v1/survivors

Parameters:

survivor[:name]
survivor[:age]
survivor[:gender]
survivor[:latitude]
survivor[:longitude]

---

#### Listing info on survivor

GET   /api/v1/survivors/:id

Response example:

{"id":4,"name":"Pedro","age":22,"gender":0,"latitude":"10","longitude":"20","items":[{"id":1,"name":"water","ammount":1,"points":4,"survivor_id":4},{"id":2,"name":"food","ammount":1,"points":3,"survivor_id":4},{"id":3,"name":"medication","ammount":1,"points":2,"survivor_id":4},{"id":4,"name":"ammunition","ammount":1,"points":1,"survivor_id":4}]}

---

#### Updating survivor's info, location

PATCH /api/v1/survivors/:id && PUT /api/v1/survivors/:id

Parameters:

survivor[:id]
survivor[:name]
survivor[:age]
survivor[:gender]
survivor[:latitude]
survivor[:longitude]

### Reports


#### Infected survivors

GET   /api/v1/reports/infected

Response example:

{"status":"success","rate":"100.0%"}

---

#### Non-infected survivors

GET   /api/v1/reports/non_infected

Response example:

{"status":"success","rate":"0.0%"}

---

#### Average Resources

GET   /api/v1/reports/average_resource

Response example:

{"status":"success","rate":{"water":"1.0","food":"1.0","medication":"1.0","ammunition":"1.0"}}

---

#### Lost Points by infected survivors

GET   /api/v1/reports/lost_points

Response example:

{"status":"success","rate":10}
