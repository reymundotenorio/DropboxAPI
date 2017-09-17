class DashboardController < ApplicationController
  def index
    @authorize_url = $flow.start
    end
end
