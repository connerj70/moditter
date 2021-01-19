# frozen_string_literal: true

require_relative "twitter/version"
require_relative "twitter/oauth"
require_relative "twitter/timeline.rb"

require "logger"

module Twitter
  class Error < StandardError; end

  class MissingOauthToken < Error; end

  class MissingOauthTokenSecret < Error; end

  def self.logger
    @@logger ||= defined?(Rails) ? Rails.logger : Logger.new(STDOUT)
  end

  def self.logger=(logger)
    @@logger = logger
  end
end
