Rails.application.routes.draw do
  get 'dropbox/code'

  get 'dropbox/list'

  get 'dropbox/download'

  get 'dropbox/upload'

  get 'dashboard/index'

  root 'dashboard#index'

  post 'dropbox/upload' => 'dropbox#upload_file', :as => :dropbox_upload_file

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
