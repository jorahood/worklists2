class NotesController < ApplicationController

  hobo_model_controller

  auto_actions :all
  auto_actions_for :listed_doc, :create
  
end
