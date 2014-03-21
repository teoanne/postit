class CategoriesController < ApplicationController

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(params.require(:category).permit(:name)) # note, contrast this with posts controller. if one, can use this, if many, use private method

    if @category.save
      flash[:notice] = "New category created."
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @category = Category.find(params[:id])
  end

end