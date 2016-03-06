# encoding: utf-8
require 'spec_helper'

describe SpinToWin do
  it 'has a version number' do
    expect(SpinToWin::VERSION).not_to be nil
  end

  describe '.with_spinner' do
    it 'should call Spinner' do
      expect(described_class::Spinner).to receive(:with_spinner)
      described_class.with_spinner
    end
  end
end
