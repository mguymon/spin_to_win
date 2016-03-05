# encoding: utf-8

require 'celluloid/current'

module SpinToWin
  #
  # rubocop:disable ClassLength
  class Spinner
    include Celluloid
    include Celluloid::Notifications

    SPIN_CHARS = %w(| / - \\)

    class << self
      def with_spinner(title = nil, &blk)
        spinner = Spinner.new(title)
        the_spin = spinner.future.spin
        result = blk.call(spinner)
        spinner.complete!
        the_spin.value
        $stderr.puts ''
        $stderr.flush
        result
      end
    end

    def initialize(title = nil)
      @title = "#{title} " if title

      subscribe('spinner_increment_todo', :on_increment_todo)
      subscribe('spinner_increment_done', :on_increment_done)
      subscribe('spinner_complete', :on_complete)
      subscribe('spinner_output', :on_output)
      subscribe('spinner_add_title', :on_add_title)
      subscribe('spinner_remove_title', :on_remove_title)
    end

    def spin(fps = 12)
      delay = 1.0 / fps
      iter = previous_msg_size = 0

      init_spinner

      # Keep spinning until told otherwise
      while @run
        output_log

        msg = build_message(iter += 1)
        previous_msg_size = print_message(msg, previous_msg_size, delay)
      end

      if @todo_count > @done_count
        puts "WARNING: spinner completed with pending jobs #{@done_count} of #{@todo_count}"
      end

      msg = "#{@title}#{SPIN_CHARS[(iter += 1) % SPIN_CHARS.length]}"
      msg << " #{@done_count} of #{@todo_count}" if @todo_count > 0
      $stderr.print msg
      $stderr.puts ''

      iter
    end

    def increment_todo!
      @todo_count += 1
    end

    def increment_done!
      @done_count += 1
    end

    def complete!
      @run = false
    end

    def on_increment_todo(*_args)
      increment_todo!
    end

    def on_increment_done(*_args)
      increment_done!
    end

    def on_output(*args)
      @log_queue << args[1]
    end

    def on_add_title(*args)
      @title_queue << args[1]
    end

    def on_remove_title(*args)
      @title_queue.reject! { |t| t == args[1] }
    end

    def on_complete(*_args)
      complete!
    end

    private

    def init_spinner
      @run = true
      @todo_count = @done_count = 0
      @log_queue = []
      @title_queue = []
    end

    def output_log
      while (log = @log_queue.shift)
        $stderr.puts log
      end unless @log_queue.empty?
    end

    def build_message(position)
      msg = "#{@title}#{SPIN_CHARS[(position) % SPIN_CHARS.length]}"
      msg << " #{@done_count} of #{@todo_count}" if @todo_count > 0
      msg << " [#{@title_queue.join('|')}]" unless @title_queue.empty?
      msg
    end

    def print_message(msg, previous_msg_size, delay)
      $stderr.print msg
      if previous_msg_size > msg.size
        $stderr.print((previous_msg_size - msg.size).times.map { ' ' }.join)
      end

      sleep delay

      $stderr.print([previous_msg_size, msg.size].max.times.map { "\b" }.join)

      msg.size
    end
  end
  # rubocop:enable ClassLength
end
