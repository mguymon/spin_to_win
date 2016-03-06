require "spin_to_win/version"
require 'spin_to_win/spinner'

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

    def with_spinner(title = nil, &blk)
      SpinToWin::Spinner.with_spinner(title, &blk)
    end
  end
end
