# encoding: utf-8
require 'spin_to_win/version'
require 'spin_to_win/spinner'

# Spinner
module SpinToWin
  class << self
    def increment_todo!(count = 1)
      Celluloid::Notifications.notifier.publish('spinner_increment_todo', count)
    end

    def increment_done!(count = 1)
      Celluloid::Notifications.notifier.publish('spinner_increment_done', count)
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

    def add_banner(msg)
      Celluloid::Notifications.notifier.publish('spinner_add_banner', msg)
    end

    def remove_banner(msg)
      Celluloid::Notifications.notifier.publish('spinner_remove_banner', msg)
    end

    def with_spinner(title = nil, charset: :line, &blk)
      SpinToWin::Spinner.with_spinner(title, charset: charset, &blk)
    end
  end
end
