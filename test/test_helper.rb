ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
Dir[Rails.root.join("test/support/**/*.rb")].each { |f| require f }

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
    def force_password!(user, password = "Password123!")
      user.update_columns(
        encrypted_password: Devise::Encryptor.digest(User, password),
        updated_at: Time.current
      )
    end
  end

  class ActionDispatch::IntegrationTest
    include Devise::Test::IntegrationHelpers
  end
end
