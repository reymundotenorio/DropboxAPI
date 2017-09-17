class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # Init Dropbox API Auth flow

  require 'dropbox_sdk'

  # Add your Dropxbox App key & App Secret as Environment variables
  @APP_KEY = ENV['DROPBOX_APP_KEY']
  @APP_SECRET = ENV['DROPBOX_APP_SECRET']

  # Open Dropbox API Auth Flow as a Global variable
  $flow = DropboxOAuth2FlowNoRedirect.new(@APP_KEY, @APP_SECRET)
end
