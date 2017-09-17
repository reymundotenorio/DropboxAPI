class DropboxController < ApplicationController
  def code
    require 'dropbox_sdk'

    code = params[:auth_code]
    access_token, user_id = $flow.finish(code)
    $client = DropboxClient.new(access_token)
    redirect_to dropbox_list_path
  end

  def list
     # Listing files
   end

  def download
    file = params[:file]
    mime_type = params[:mime_type]

    contents, metadata = $client.get_file_and_metadata(file)

    dir = Rails.root.join('public', 'downloads')
    Dir.mkdir(dir) unless Dir.exist?(dir)

    file.slice!(0)

    puts dir.join(file)

    File.open(dir.join(file), 'wb') do |file|
      file.write contents
    end

    send_file(dir.join(file), type: mime_type)
   end

  def upload
     # Upload view
   end

  def upload_file
    uploaded_file = params[:upload_file][:my_file]

    file_name = uploaded_file.original_filename
    file_type = uploaded_file.content_type

    temp_file = uploaded_file.tempfile

    upload_dir = Rails.root.join('public', 'uploads')
    Dir.mkdir(upload_dir) unless Dir.exist?(upload_dir)

    File.open(upload_dir.join(file_name), 'wb') do |file|
      file.write temp_file.read
    end

    my_file = File.open(upload_dir.join(file_name), 'rb', &:read)

    response = $client.put_file('/' + file_name, my_file)
    puts 'uploaded:', response.inspect
   end
end
