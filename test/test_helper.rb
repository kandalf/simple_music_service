ENV['RAILS_ENV'] ||= 'test'
require_relative "../config/environment"
require "rails/test_help"
require "rack/test"
require "minitest/spec"
require "minitest/autorun"
require "minitest/assertions"

require_relative "./spawners"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

class MiniTest::Spec
  include Rack::Test::Methods

  def app
    Rails.application
  end

  def run(*args, &block)
    ActiveRecord::Base.transaction do
      super
    end
  end
end
