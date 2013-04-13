#!/usr/bin/env ruby

require 'sqlite3'
require 'active_record'
require_relative 'db/config.rb'
require_relative 'lib/gem_example'

ActiveRecord::Base.establish_connection(MyConfig::CONFIG)


#take the version from the command line, or use nil if there is no command line argument
ActiveRecord::Migrator.migrate File.expand_path('../db/migrate/', __FILE__), ARGV[0] ? ARGV[0].to_i : nil
