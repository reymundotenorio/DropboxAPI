class DashboardController < ApplicationController
  def index
    # Auth URL -> Get Auth code of the App
    @authorize_url = $flow.start
    end
end
