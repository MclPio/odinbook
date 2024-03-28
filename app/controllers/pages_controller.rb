class PagesController < ApplicationController
  before_action :authenticate_user!

  def notifications
  end
end
