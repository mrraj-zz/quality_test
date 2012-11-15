class ApplicationController < ActionController::Base

  #This is for new branch
  protect_from_forgery

  before_filter :authenticate_user!, :redirect_www_to_normal

  def redirect_www_to_normal
    redirect_to request.url.gsub(/www./, "") unless request.url.scan(/\/\/www./).blank?
  end

  def render_404
    render :template => "errors/404", :format => [:html], :layout => "application"
  end
end
