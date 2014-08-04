# fluent-plugin-ohai

This is an [ohai](http://docs.getchef.com/ohai.html) plugin for [fluentd](fluentd.org), 
a popular log collector. The purpose of this input plugin is to run ohai and emit the data.
There are many other ways this can be achieved (e.g., in_tail + cron job) but I wanted to 
learn how to extend fluentd.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'fluent-plugin-ohai'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fluent-plugin-ohai

## Usage

Add the following configuration option in fluentd (or td-agent): 

     <source>
       type ohai
       tag ohai.message # optional; default: ohai.message
       hostname ENV["HOSTNAME"] # optional, default: current hostname (can override it here if needed)
       ohai_path /path/to/ohai # optional, directory where ohai binary is located
       interval '1200m' # optional, default every 24h data is read from ohai
     </source>

## Contributing

1. Fork it ( https://github.com/frosenberg/fluent-plugin-ohai/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
