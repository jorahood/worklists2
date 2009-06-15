class HotitemsController < ApplicationController

  hobo_model_controller

  auto_actions :all

  autocomplete :limit => 20, :query_scope => :hotitem_starts

end
