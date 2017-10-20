class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  def new
  end

  def create
    user = User.new(first_name:params[:first_name], last_name:params[:last_name], email:params[:email], location:params[:location], state:params[:state], password:params[:password])
    if user.valid?
      user.save
      redirect_to '/users/new'
    else
      flash[:errors] = user.errors.full_messages
      redirect_to '/users/new'
    end
  end

  def edit
    if session[:user_id].to_s != params[:id]
      redirect_to '/events'
    end
    @user = User.find(params[:id])
  end

  def update
    update = User.update(params[:id], first_name:params[:first_name], last_name:params[:last_name], email:params[:email], location:params[:location], state:params[:state])
    if update.valid?
      redirect_to '/events'
    else
      flash[:errors] = update.errors.full_messages
      redirect_to '/users/' + params[:id].to_s + '/edit'
    end
  end
end
