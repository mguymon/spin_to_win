# SpinToWin

Simple ruby spinner that allows on the fly notifications in the format of:

    :title :spinner :finished of :todo [:banner]

The bare bones spinner is
```ruby
SpinToWin.with_spinner { sleep 1 }

#=> \
```

With a title is
```ruby
SpinToWin.with_spinner('Zzzz') { sleep 1 }

#=> Zzzz \
```

With a title and banner:
```ruby
SpinToWin.with_spinner('Zzzz') { |spinner| spinner.banner('sleepy'); sleep 1 }

#=> Zzzz \ [sleepy]
```

The title is persistent but the banner can be changed with calls to the yielded `spinner`

With title, banner, and todos
```ruby
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

#=> Zzzz \ 3 of 3 [wake up!]
```

## Charsets

Supports for UTF-8 chars in the spinner

* line:          `|` `/` `-` `\\`
* short_braille: `⠋` `⠙` `⠹` `⠸` `⠼` `⠴` `⠦` `⠧` `⠇` `⠏`
* braille:       `⣷` `⣯` `⣟` `⡿` `⢿` `⣻` `⣽` `⣾`
* bar:           `┤` `┘` `┴` `└` `├` `┌` `┬` `┐`
* circle:        `◐` `◓` `◑` `◒`
* bounce:        `| ●    |` `|  ●   |` `|   ●  |` `|    ● |` `|     ●|` `|    ● |` `|   ●  |` `|  ●   |` `| ●    |` `|●     |`
* clock:         `🕐` `🕑` `🕒` `🕓` `🕔` `🕕` `🕖` `🕗` `🕘` `🕙` `🕚`
* earth:         `🌍` `🌍` `🌏` `🌏` `🌎` `🌎`
* moon:          `🌑` `🌒` `🌓` `🌔` `🌕` `🌖` `🌗` `🌘`
* arrow:         `←` `↖` `↑` `↗` `→` `↘` `↓` `↙`
* noise:         `▓` `▓` `▒` `▒` `░` `░` `▒` `▒`
* burger:        `☱` `☱` `☲` `☲` `☴` `☴` `☲` `☲`
* dot:           `⠈` `⠐` `⠠` `⢀` `⡀` `⠄` `⠂` `⠁`

The spinner charset can be set by setting the `charset` named parameter:

```ruby
SpinToWin.with_spinner(charset: :braille) { sleep 1 }

#=> ⣷
```

## Threads

Spin to Win is built using [Celluloid](https://github.com/celluloid/celluloid) and was designed to be used by multiple threads. The banner can show an array of active threads.

```ruby
SpinToWin.with_spinner('Dreaming about:') do |spinner|
  threads = [
    Thread.new do
      SpinToWin.add_banner('ham')
      sleep 1
      SpinToWin.increment_done!
      SpinToWin.remove_banner('ham')
    end,
    Thread.new do
      SpinToWin.add_banner('sheep')
      sleep 2
      SpinToWin.increment_done!
      SpinToWin.remove_banner('sheep')
    end,
    Thread.new do
      SpinToWin.add_banner('socks')
      sleep 3
      SpinToWin.increment_done!
      SpinToWin.remove_banner('sock')
    end
  ]
  SpinToWin.increment_todo!(threads.size)

  threads.each(&:join)
end

#=> Dreaming about: \ 0 of 3 [ham|sheep|socks]
```

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

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/spin_to_win.
