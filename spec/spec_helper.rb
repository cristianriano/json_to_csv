# frozen_string_literal: true

ENV['ENVIRONMENT'] ||= 'test'

require File.expand_path('../config/environment.rb', __dir__)

require 'rack/test'

RSpec.configure do |config|
  config.expose_dsl_globally = true

  config.expect_with :rspec do |c|
    c.include_chain_clauses_in_custom_matcher_descriptions = true
    c.syntax = :expect
    c.max_formatted_output_length = nil # Prints all the output
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.example_status_persistence_file_path = 'spec/examples.txt'

  config.disable_monkey_patching!

  config.warnings = true

  config.profile_examples = 3

  config.order = :random
  Kernel.srand config.seed

  def app
    described_class
  end
end
