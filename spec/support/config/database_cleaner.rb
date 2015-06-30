RSpec.configure do |config|

  # Ref: https://www.relishapp.com/rspec/rspec-rails/docs/transactions
  config.use_transactional_fixtures = false

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do |example|
    DatabaseCleaner.strategy = example.metadata[:js] ? :deletion : :transaction
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.append_after(:each) do
    DatabaseCleaner.clean
  end
end

