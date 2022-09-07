# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include ApiResponders
  include ApiRescuable
  include Authenticable
  include Pundit::Authorization

  private

    def current_user
      @current_user
    end
end
