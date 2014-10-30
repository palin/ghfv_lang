class GithubApiController < ApplicationController
  rescue_from Github::Error::GithubError, with: :error_handler
  rescue_from ActionController::ParameterMissing, with: :error_handler

  def find
    @language = LanguageFinder.new(user_params).favorite
    @user_name = user_params[:name]
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end

  def error_handler
    redirect_to root_url, alert: 'Error occured!'
  end
end
