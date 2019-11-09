# frozen_string_literal: true

# Shared behaviour with other controllers
class ApplicationController < Sinatra::Base
  helpers ApplicationHelper

  configure :production, :development do
    enable :logging
  end

  configure :test, :development do
    require 'pry'
  end
end
