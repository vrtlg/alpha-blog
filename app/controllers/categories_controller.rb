class CategoriesController < ApplicationController
  before_action :require_admin, only: [:new, :create, :edit]

  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
    @category_articles = @category.articles
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "Category created"
      redirect_to categories_path
    else
      render 'new'
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      flash[:notice] = "Category updated"
      redirect_to category_path(@category)
    else
      render 'edit'
    end
  end

  private
  def category_params
    params.require(:category).permit(:name)
  end

  def require_admin
    if !logged_in? || (logged_in? and !current_user.admin?) #need to be logged in as admin to do this
      flash[:notice] = "You must be an administrator to perform that action"
      redirect_to categories_path
    end
  end

end
