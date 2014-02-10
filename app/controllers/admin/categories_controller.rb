class Admin::CategoriesController < ApplicationController
  before_action :find_categories, only: [:destroy,:edit,:update]
  
  def index
    @category_counts=Categorization.group(:category_id).count
    @categories=Category.all
  end

  def new
    @category=Category.new
  end

  def create
    @category = Category.new params.require(:category).permit([:name])
    if @category.save
      redirect_to [:admin, :categories] , notice: "Category created successfully"
    else
      render :new, alert: "You suck"
    end
  end

  def edit

  end

  def update
    if @category.update_attributes(category_params)
      redirect_to [:admin, :categories], notice: "Event updated successfully"
    else
      render :edit, alert: "You suck"
    end
  end



  def destroy
    if @category.destroy
      redirect_to admin_categories_path, notice: "Category deleted successfully"
    else
      redirect_to admin_categories_path, alert: "Problem man"
    end
  end

private

  def find_categories
    @category = Category.find params[:id]
  end

  def category_params
    params.require(:category).permit([:name])
  end

end