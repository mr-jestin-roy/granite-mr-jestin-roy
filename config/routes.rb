# frozen_string_literal: true

Rails.application.routes.draw do
  resources :tasks, except: %i[new edit], param: :slug

  root "home#index"
  get "*path", to: "home#index", via: :all
end
