# Capistrano3::Eye

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'capistrano3-eye'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install capistrano3-eye

## Usage

Require in `Capfile` to use the default task:

```ruby
require 'capistrano3/eye'
```

You will get the following tasks

```ruby
cap eye:load                    # Loads application
cap eye:info
cap eye:start
cap eye:stop
cap eye:restart
cap eye:delete
cap eye:monitor
cap eye:unmonitor
cap eye:history
```

Configurable options (copy into deploy.rb), shown here with examples:

```ruby
# Path to look for custom config template
# `:default` will use the bundled eye template
# default value: :default
set :eye_config_file, "#{stage_config_path}/#{fetch :stage}/eye.rb.erb"

# default value: "#{fetch :application}"
set :eye_application, "my-other-application-name"

set :eye_processes,
[
    {
        cmd: 'unicorn -load df'
        log: 
    }

]
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/capistrano3-eye/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
