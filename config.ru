# frozen_string_literal: true

require File.expand_path('config/environment', __dir__)

map('/check') { run CheckController }
