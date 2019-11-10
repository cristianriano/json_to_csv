# frozen_string_literal: true

# Set the environment
environment ENV["ENVIRONMENT"] || "development"

# Do not daemonize the app server to the background
daemonize false

# Store the server info state to `/tmp/puma.state`
state_path "/tmp/puma.state"

# Threads: minimum 1, maximum 64
threads 1, 64

# Cluster mode: Process 2
workers 2
preload_app!
