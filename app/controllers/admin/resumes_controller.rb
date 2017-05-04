class Admin::ResumesController < ApplicationController
  before_action :authenticate_user!

  def index
    @resumes = Resume.where(:user_id => current_user.id).all
  end
  
end
