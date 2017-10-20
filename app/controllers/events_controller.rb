class EventsController < ApplicationController
  def index
    @in_state = Event.where(state:current_user.state)
    @out_of_state = Event.where.not(state:current_user.state) 
  end

  def create
    event = Event.new(name:params[:name], date:params[:date], location:params[:location], state:params[:state], user_id:params[:user_id])
    if event.valid?
      event.save
      redirect_to '/events'
    else
      flash[:errors] = event.errors.full_messages
      redirect_to '/events'
    end
  end

  def show
    @event = Event.find(params[:id])
    @comments = Comment.where(event_id:params[:id])
  end

  def join
    Attendee.create(event_id:params[:id], user_id:session[:user_id])
    redirect_to '/events'
  end

  def cancel
    Attendee.destroy(Attendee.find_by(event_id:params[:id], user_id:session[:user_id]))
    redirect_to '/events'
  end

  def comment
    Comment.create(user_id:session[:user_id], event_id:params[:id], content:params[:content])
    redirect_to '/events/' + params[:id].to_s
  end

  def edit
    @event = Event.find(params[:id])
    if session[:user_id] != @event.user.id
      redirect_to '/events'
    end
  end

  def update
    if session[:user_id] != Event.find(params[:id]).user.id
      redirect_to '/events'
    end
    update = Event.update(params[:id], name:params[:name], date:params[:date], location:params[:location], state:params[:state])
    if update.valid?
      redirect_to '/events'
    else
      flash[:errors] = update.errors.full_messages
      redirect_to '/events/' + params[:id].to_s + '/edit'
    end
  end

  def destroy
    if session[:user_id] != Event.find(params[:id]).user.id
      redirect_to '/events'
    end
    Event.destroy(params[:id])
    redirect_to '/events'
  end
end
