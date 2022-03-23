class StaticController < ApplicationController

  def show
    render(params[:id] || 'home')
  end

  # The homepage is authorized
  def authorized?
    params[:id].blank? ? true : super
  end

end
