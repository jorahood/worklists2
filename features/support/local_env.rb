# support stubs:
require "spec/mocks"

# support factory_girl
require 'factory_girl'
require 'spec/factories'

# pickle support, I get "undefined local variable or method `capture_model' for main:Object (NameError)" unless I put the pickle/world requirement here instead of in pickle.rb
require 'pickle/world'
require 'pickle/path/world'
