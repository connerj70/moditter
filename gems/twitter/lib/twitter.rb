# frozen_string_literal: true

require_relative "twitter/version"
require_relative "twitter/oauth"
require_relative "twitter/timeline"
require_relative "twitter/tweet"
require_relative "twitter/client"

require_relative "twitter/mock_oauth"

require "logger"

module Twitter
  class Error < StandardError; end

  class MissingOauthToken < Error; end

  class MissingOauthTokenSecret < Error; end

  class RateLimitExceeded < Error; end

  def self.logger
    @@logger ||= defined?(Rails) ? Rails.logger : Logger.new(STDOUT)
  end

  def self.logger=(logger)
    @@logger = logger
  end
end
