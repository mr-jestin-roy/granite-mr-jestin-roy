# frozen_string_literal: true

require "sidekiq/web"
require "sidekiq/cron/web"

Rails.application.routes.draw do
  def draw(routes_name)
    instance_eval(File.read(Rails.root.join("config/routes/#{routes_name}.rb")))
  end

  draw :sidekiq

  # Sidekiq::Web.use Rack::Auth::Basic do |username, password|
  #   ActiveSupport::SecurityUtils.secure_compare(
  #     ::Digest::SHA256.hexdigest(username),
  #     ::Digest::SHA256.hexdigest(ENV["SIDEKIQ_USERNAME"])) &
  #     ActiveSupport::SecurityUtils.secure_compare(
  #       ::Digest::SHA256.hexdigest(password),
  #       ::Digest::SHA256.hexdigest(ENV["SIDEKIQ_PASSWORD"]))
  # end
  # mount Sidekiq::Web, at: "/sidekiq"

  constraints(lambda { |req| req.format == :json }) do
    resources :tasks, except: %i[new edit], param: :slug
    resources :users, only: %i[create index]
    resource :session, only: %i[create destroy]
    resources :comments, only: :create
    resource :preference, only: %i[show update] do
      patch :mail, on: :collection
    end
    resources :tasks, except: %i[new edit], param: :slug do
      collection do
        resource :report, only: %i[create], module: :tasks do
          get :download, on: :collection
        end
      end
    end

  end

  root "home#index"
  get "*path", to: "home#index", via: :all
end
