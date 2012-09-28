class UsersController < ApplicationController

  def index
    @users = User.paginate(:page => params[:pare])

    respond_to do |format|
      format.html
      format.json { render json: @users }
    end
  end
end
