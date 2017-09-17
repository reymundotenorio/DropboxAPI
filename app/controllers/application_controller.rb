class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  require 'dropbox_sdk'

  @APP_KEY = ENV["DROPBOX_APP_KEY"]
  @APP_SECRET = ENV["DROPBOX_APP_SECRET"]

  $flow = DropboxOAuth2FlowNoRedirect.new(@APP_KEY, @APP_SECRET)
end
