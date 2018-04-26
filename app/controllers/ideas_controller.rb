class IdeasController < ApplicationController
  before_action :require_login
  def index
    @ideas = Idea.includes(:likes)
  end

  def create
    @idea = Idea.new
    @idea.idea = params[:idea][:idea]
    @idea.user = current_user
    unless @idea.save
      flash[:errors] = @idea.errors.full_messages
    end
    redirect_to "/ideas"
  end

  def show
    @idea = Idea.find(params[:id])
  end

  def destroy
    @delete = Idea.find(params[:id])
    if @delete.user == current_user
      p @delete
      @delete.destroy
    end
    redirect_to "/ideas"
  end

  def like
    p "**************************************************************"
    p current_user.id  
    Like.create(user:current_user, idea:Idea.find(params[:idea_id]))
    p "**************************************************************"
    p "**************************************************************"
    p "**************************************************************"
    redirect_to '/ideas'
end

def unlike
   p "1================="
   p (params[:id])
   p Idea.find(params[:id])
   @like = Like.find_by(user:current_user, idea:Idea.find(params[:id]))
   @like.destroy if @like
   redirect_to '/ideas'
end
end
