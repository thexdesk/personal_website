ENV["RAILS_ENV"] ||= 'test'

require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'

Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.mock_with :rspec
  config.render_views
  config.use_transactional_fixtures = true
  config.infer_base_class_for_anonymous_controllers = true
  config.order = :random

  config.before do
    Comment.any_instance.stub(:spam?).and_return(false)
    Comment.any_instance.stub(:spam!).and_return(true)
    ContactMessage.any_instance.stub(:spam?).and_return(false)
    ContactMessage.any_instance.stub(:spam!).and_return(true)
  end
end

def login_as(user)
  session[:user_id] = user.id
end
