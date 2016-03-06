# SpinToWin

Simple ruby spinner that allows on the fly notifications in the format of:

    :title :spinner :finished of :todo [:banner]

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

    SpinToWin.with_spinner('Fancy Demo') do |spinner|
      spinner.banner 'step 1'
      sleep 1
      spinner.banner 'step 2'
      sleep 1
    end
    
    Fancy Demo \ 1 of 3 [step 1]

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/spin_to_win.
