begin ; require 'rubygems' rescue LoadError; end
require 'active_record' # ActiveRecord loads the Benchmark library automatically
require 'active_record/version'

require File.expand_path(File.join( File.dirname( __FILE__ ), '..', 'init.rb' ))
