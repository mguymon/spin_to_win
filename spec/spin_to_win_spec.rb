require 'spec_helper'

describe SpinToWin do
  it 'has a version number' do
    expect(SpinToWin::VERSION).not_to be nil
  end

  describe '.with_spinner' do
    context 'with a block' do
      subject { described_class.with_spinner('title') { 'test' } }
      let(:expected_output) do
        (0..12).map do |x|
          spin = SpinToWin::Spinner::SPIN_CHARS[x]
          %(title #{spin}\b\b\b\b\b\b\b)
        end.join < "\n\n"
      end

      it 'outputs a spinner with a title' do
        expect { subject }.to output(expected_output).to_stderr
      end

      it 'returns result of block' do
        expect(subject).to eq 'test'
      end
    end

    context 'with events' do
      context 'using incrementing todo' do
        subject do
          described_class.with_spinner do |spinner|
            spinner.increment_todo!
            spinner.increment_todo!
            sleep 1
            spinner.increment_done!
            spinner.increment_done!
          end
        end

        it 'outputs a spinner with a count' do
          expect { subject }.to output(/2 of 2/).to_stderr
        end
      end

      context 'using complete!' do
        subject do
          described_class.with_spinner do |spinner|
            spinner.increment_todo!
            spinner.increment_todo!

            spinner.complete!
          end
        end

        it 'outputs without finishing jobs' do
          expect { subject }.to_not output(/2 of 2/).to_stderr
        end

        it 'should raise a warning for unfinished jobs' do
          expect { subject }.to_not output('WARNING: spinner completed with pending jobs 0 of 2').to_stderr
        end
      end
    end
  end
end
