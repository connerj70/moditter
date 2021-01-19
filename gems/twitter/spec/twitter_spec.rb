# frozen_string_literal: true

RSpec.describe Twitter do
  it "has a version number" do
    expect(Twitter::VERSION).not_to be nil
  end

  it "can get a users timeline" do
    body = Twitter.get_timeline()
    puts "BODY #{body}"
  end
end
