class ArticlesController < ApplicationController

  def index
    @all_articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    # render plain: params[:article].inspect # inspect will display the created article -- this displays the hash
    @article = Article.new(article_params)
    if @article.save
      flash[:notice]="Article created"
      redirect_to article_path(@article)
    else
      render :new
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def show
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      flash[:notice] = "Article updated"
      redirect_to article_path(@article)
    else
      render :edit
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to articles_path
    flash[:notice] = "Article was deleted"
  end

  private
    def article_params
      params.require(:article).permit(:title, :description)
    end
end
