class LikesController < ApplicationController
  before_action :load_likeable
  
  
  def create
    @like = @likeable.likes.build(user_id: current_user.id)
    if @like.save
      flash[:notice] = 'Liked!!!!'
      redirect_to root_path
    else
      flash[:notice] = 'Error liking?'
      redirect_to root_path
    end
  end

  def destroy
    @like = @likeable.likes.find(params[:id])
    if @like.destroy
      flash[:notice] = 'Like destroyed :( !!!!'
      redirect_to root_path
    else
      flash[:notice] = 'Could not destroy like!!!'
      redirect_to root_path
    end
  end

  private

  def load_likeable
    resource, id = request.path.split('/')[1, 2]
    @likeable = resource.singularize.classify.constantize.find(id)
  end
end
