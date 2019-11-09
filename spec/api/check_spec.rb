# frozen_string_literal: true

require 'spec_helper'

RSpec.describe CheckController do
  include Rack::Test::Methods

  it 'returns OK' do
    get '/'

    expect(last_response.status).to eq 200
    expect(last_response.body).to eq 'OK'
  end
end
