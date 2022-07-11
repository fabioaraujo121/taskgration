# Taskgration
Short description and motivation.

## Usage
How to use my plugin.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'taskgration'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ rake taskgration:install:migrations
```

## Usage

### 1. Creating a task to migrate
```bash
$ rails generate taskgration:create YOUR_TASK_MIGRATION_NAME
```

### 2. Running the unapplied tasks migrations
```bash
$ rake taskgration:up
```

### 3. Rolling back applied tasks migrations
```bash
$ rake taskgration:down TASKGRATION_VERSION=YOUR_VERSION_NUMBER #=> Rollback 1 specific version
$ rake taskgration:down TASKGRATION_STEPS=QUANTITY_OF_STEPS #=> Rollback the number of times passed
$ rake taskgration:down #=> Rollback always the newest created migration
```

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
