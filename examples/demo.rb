require 'spin_to_win'

SpinToWin.with_spinner('Fancy Demo') do |spinner|
  spinner.increment_todo!
  spinner.increment_todo!
  spinner.increment_todo!

  ('a'..'c').each do |step|
    spinner.banner("downloading #{step}")
    sleep 1
    spinner.increment_done!
  end
end
