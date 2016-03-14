# encoding: utf-8

require 'celluloid/current'

module SpinToWin
  #
  # rubocop:disable ClassLength
  class Spinner
    include Celluloid
    include Celluloid::Notifications

    SPIN_CHARSET = {
      line:          %w(| / - \\).freeze,
      short_braille: %w(⠋ ⠙ ⠹ ⠸ ⠼ ⠴ ⠦ ⠧ ⠇ ⠏).freeze,
      braille:       %w(⣷ ⣯ ⣟ ⡿ ⢿ ⣻ ⣽ ⣾).freeze,
      bar:           %w(┤ ┘ ┴ └ ├ ┌ ┬ ┐).freeze,
      circle:        %w(◐ ◓ ◑ ◒).freeze,
      bounce:        ["| ●    |", "|  ●   |", "|   ●  |", "|    ● |", "|     ●|", "|    ● |", "|   ●  |", "|  ●   |", "| ●    |", "|●     |"].freeze,
      clock:         %w(🕐 🕑 🕒 🕓 🕔 🕕 🕖 🕗 🕘 🕙 🕚).freeze,
      earth:         %w(🌍 🌍 🌏 🌏 🌎 🌎).freeze,
      moon:          %w(🌑 🌒 🌓 🌔 🌕 🌖 🌗 🌘).freeze,
      arrow:         %w(← ↖ ↑ ↗ → ↘ ↓ ↙).freeze,
      noise:         %w(▓ ▓ ▒ ▒ ░ ░ ▒ ▒).freeze,
      burger:        %w(☱ ☱ ☲ ☲ ☴ ☴ ☲ ☲).freeze,
      dot:           %w(⠈ ⠐ ⠠ ⢀ ⡀ ⠄ ⠂ ⠁).freeze
    }.freeze

    class << self
      # rubocop:disable UnusedMethodArgument
      def with_spinner(title = nil, charset: :line, &blk)
        spinner = Spinner.new(title, charset: charset)
        the_spin = spinner.future.spin
        result = yield(spinner)
        spinner.complete!
        the_spin.value
        $stderr.puts ''
        $stderr.flush
        result
      end
      # rubocop:enable UnusedMethodArgument
    end

    def initialize(title = nil, charset: :line)
      @title = title
      @charset = SPIN_CHARSET[charset.to_sym]

      subscribe('spinner_increment_todo', :on_increment_todo)
      subscribe('spinner_increment_done', :on_increment_done)
      subscribe('spinner_complete', :on_complete)
      subscribe('spinner_output', :on_output)
      subscribe('spinner_set_banner', :on_set_banner)
      subscribe('spinner_add_banner', :on_add_banner)
      subscribe('spinner_remove_banner', :on_remove_banner)
    end

    def spin(fps = 12)
      delay = 1.0 / fps
      iteration = previous_msg_size = 0

      init_spinner

      # Keep spinning until told otherwise
      while @run
        output_log

        msg = build_message(iteration += 1)
        previous_msg_size = print_message(msg, previous_msg_size, delay)
      end

      if @todo_count > @done_count
        puts "WARNING: spinner completed with pending jobs #{@done_count} of #{@todo_count}"
      end

      $stderr.print build_message(iteration)
      $stderr.puts ''

      iteration
    end

    def increment_todo!(count = 1)
      @todo_count += count
    end

    def increment_done!(count = 1)
      @done_count += count
    end

    def complete!
      @run = false
    end

    def output(msg)
      @log_queue << msg
    end

    def banner(banner)
      @banner_queue = [banner]
    end

    def on_increment_todo(*args)
      increment_todo!(args[1] || 1)
    end

    def on_increment_done(*args)
      increment_done!(args[1] || 1)
    end

    def on_output(*args)
      @log_queue << args[1]
    end

    def on_set_banner(*args)
      @banner_queue = [args[1]]
    end

    def on_add_banner(*args)
      @banner_queue << args[1]
    end

    def on_remove_banner(*args)
      @banner_queue.reject! { |t| t == args[1] }
    end

    def on_complete(*_args)
      complete!
    end

    private

    def init_spinner
      @run = true
      @todo_count = @done_count = 0
      @log_queue = []
      @banner_queue = []
    end

    def output_log
      while (log = @log_queue.shift)
        $stderr.puts log
      end unless @log_queue.empty?
    end

    def build_message(position)
      msg = "#{@title} #{@charset[position % @charset.length]}"
      msg << " #{@done_count} of #{@todo_count}" if @todo_count > 0
      msg << " [#{@banner_queue.join('|')}]" unless @banner_queue.empty?
      msg
    end

    def print_message(msg, previous_msg_size, delay)
      $stderr.print msg
      if previous_msg_size > msg.size
        white_space = Array.new(previous_msg_size - msg.size) { ' ' }.join
        $stderr.print(white_space)
      end

      sleep delay

      back_space = Array.new([previous_msg_size, msg.size].max) { "\b" }.join
      $stderr.print(back_space)

      msg.size
    end
  end
  # rubocop:enable ClassLength
end
