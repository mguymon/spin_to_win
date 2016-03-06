# encoding: utf-8
require 'spin_to_win/version'
require 'spin_to_win/spinner'

# Spinner
module SpinToWin
  class << self
    def increment_todo!
      Celluloid::Notifications.notifier.publish('spinner_increment_todo')
    end

    def increment_done!
      Celluloid::Notifications.notifier.publish('spinner_increment_done')
    end

    def complete!
      Celluloid::Notifications.notifier.publish('spinner_complete')
    end

    def output(msg)
      Celluloid::Notifications.notifier.publish('spinner_output', msg)
    end

    def banner(msg)
      Celluloid::Notifications.notifier.publish('spinner_set_banner', msg)
    end

    def remove_banner(msg)
      Celluloid::Notifications.notifier.publish('spinner_remove_banner', msg)
    end

    def with_spinner(title = nil, char = :line, &blk)
      SpinToWin::Spinner.with_spinner(title, char, &blk)
    end
  end
end
