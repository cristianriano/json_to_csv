# frozen_string_literal: true

# Shared behaviour with other controllers
class ApplicationController < Sinatra::Base
  helpers ApplicationHelper

  configure :production, :development do
    enable :logging
    enable :raise_errors
    disable :raise_errors
    disable :show_exceptions
  end

  configure :test, :development do
    require 'pry'

    enable :show_exceptions
  end
end
