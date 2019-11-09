# frozen_string_literal: true

require "app/controllers/application_controller"

class CheckController < ApplicationController
  get "/" do
    "OK"
  end
end
