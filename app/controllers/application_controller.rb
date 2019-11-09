# frozen_string_literal: true

class ApplicationController < Sinatra::Base
  helpers ApplicationHelper

  configure :production, :development do
    enable :logging
  end

  configure :test, :development do
    require "pry"
  end
end
