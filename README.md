# SpinToWin

Simple ruby spinner that allows on the fly notifications in the format of:

    :title :spinner :finished of :todo [:banner]
    
The bare bones spinner is `SpinToWin.with_spinner { sleep 1 }`

With a title is `SpinToWin.with_spinner('Zzzz') { sleep 1 }` => Zzzz \

With a title and banner:

    SpinToWin.with_spinner('Zzzz') { |spinner| spinner.banner('sleepy'); sleep 1 }` => Zzzz \ [sleepy]

The title is persistent but the banner can be changed with calls to the yielded `spinner`

With title, banner, and todos

    SpinToWin.with_spinner('Zzzz') do |spinner|
        spinner.increment_todo!(3)
        
        spinner.banner('snore')
        sleep 1
        spinner.increment_done!
        
        spinner.banner('dream')
        sleep 1
        spinner.increment_done!
        
        spinner.banner('wake up!')
        sleep 1
        spinner.increment_done!
    end
    
    Zzzz \ 3 of 3 [wake up!]

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
    
    Fancy Demo \ 1 of 3 [step 1]

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/spin_to_win.
