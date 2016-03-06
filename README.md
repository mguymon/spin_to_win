# SpinToWin

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/spin_to_win`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'spin_to_win'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install spin_to_win

## Usage

![](https://raw.githubusercontent.com/mguymon/spin_to_win/master/examples/demo.gif)

    SpinToWin.with_spinner do |spinner|
      spinner.banner 'step 1'
      sleep 1
      spinner.banner 'step 2'
      sleep 1
    end

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/spin_to_win.
