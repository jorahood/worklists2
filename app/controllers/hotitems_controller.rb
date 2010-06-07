class HotitemsController < ApplicationController

  hobo_model_controller

  auto_actions :all

  autocomplete :limit => 20

end
