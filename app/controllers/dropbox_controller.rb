class DropboxController < ApplicationController
  def code
    require 'dropbox_sdk'

    begin
        # Get Inputed code
        code = params[:auth_code]
        # Add access code to Flow
        access_token, user_id = $flow.finish(code)
        # Set a new Client
        $client = DropboxClient.new(access_token)
      rescue => error
        flash[:error] = 'Failed connected to Dropbox!'
      end

    flash[:notice] = 'Successfully connected to Dropbox!'

    # Redirect to folder list
    redirect_to dropbox_list_path
  end

  def list
     # Listing files
   end

  def download
    # Get selected file
    download_file = params[:download_file]
    # Get selected file mime type
    mime_type = params[:mime_type]

    # Get file and metadata from Dropbox
    contents, metadata = $client.get_file_and_metadata(download_file)

    # Create the downloads dir in the public folder if not exist
    dir = Rails.root.join('public', 'downloads')
    Dir.mkdir(dir) unless Dir.exist?(dir)

    # Remove the slash from the file name
    download_file.slice!(0)

    # Writing the file into the downloads dir
    File.open(dir.join(download_file), 'wb') do |file|
      file.write contents
    end

    # Open download file window
    send_file(dir.join(download_file), type: mime_type)

    puts 'uploaded:', response.inspect
   end

  def upload
     # Upload view
   end

  def upload_file
    # Get upload file
    upload_file = params[:upload_file][:my_file]
    # Get upload file name
    file_name = upload_file.original_filename
    # Get upload file mime type
    file_type = upload_file.content_type
    # Get upload file contents
    file_contents = upload_file.tempfile

    # Create the uploads dir in the public folder if not exist
    upload_dir = Rails.root.join('public', 'uploads')
    Dir.mkdir(upload_dir) unless Dir.exist?(upload_dir)

    # Writing the file into the uploads dir
    File.open(upload_dir.join(file_name), 'wb') do |file|
      file.write file_contents.read
    end

    # Reading the uploaded file
    uploaded_file = File.open(upload_dir.join(file_name), 'rb', &:read)

    # Uploading file to Dropbox
    response = $client.put_file('/' + file_name, uploaded_file)

    puts 'uploaded:', response.inspect
   end
end
