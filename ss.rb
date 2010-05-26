#!/usr/bin/env ruby
require 'yaml'

config_path = File.join(File.dirname(__FILE__), 'rappaport.yml')
apps = YAML.load_file(config_path)
current_app = Dir.pwd.split("/").last

if apps[current_app]
  port = apps[current_app]["port"]
  server = apps[current_app]["server"]
  
  case apps[current_app]['runner']
  when 'unicorn'
    command = "unicorn_rails"
    command << " -p #{port}" if port
    command << " -E #{server}" if server
  else
    command = "ruby script/server"
    command << " -p #{port}" if port
    command << " -e #{server}" if server
  end
  
  system command
else
  puts "No definition set for #{current_app}. Using defaults."
  system "ruby script/server"
end