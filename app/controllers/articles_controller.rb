class ArticlesController < ApplicationController
  before_action :find_article, only: [:edit, :show, :update, :destroy]

  def index
    @all_articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    # render plain: params[:article].inspect # inspect will display the created article -- this displays the hash
    @article = Article.new(article_params)
    @article.user = User.first
    if @article.save
      flash[:notice]="Article created"
      redirect_to article_path(@article)
    else
      render :new
    end
  end

  def edit
  end

  def show
  end

  def update
    if @article.update(article_params)
      flash[:notice] = "Article updated"
      redirect_to article_path(@article)
    else
      render :edit
    end
  end

  def destroy
    @article.destroy

    redirect_to articles_path
    flash[:notice] = "Article was deleted"
  end

  private
    def find_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :description)
    end
end
