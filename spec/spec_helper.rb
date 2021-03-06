RSpec.configure do |config|
  config.before(:each) do
    ip_response_file = File.new("spec/support/ip_response_file.txt")
    stub_request(:get, "http://freegeoip.net/json/72.229.28.185").to_return(ip_response_file)
    stub_request(:get, "http://freegeoip.net/json/104.15.101.238").to_timeout
  end

  config.expect_with :rspec do |expectations|

    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  if config.files_to_run.one?
    config.default_formatter = 'doc'
  end

  config.profile_examples = 10

  config.order = :random

  Kernel.srand config.seed

end
