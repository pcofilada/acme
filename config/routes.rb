Rails.application.routes.draw do
  root 'homepage#index'

  post :import, to: 'homepage#import'
end
