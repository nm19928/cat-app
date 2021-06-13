class CatController < ApplicationController
  before_action :require_user
  before_action :require_own_cat, only: [:edit,:update,:show]

  def index
    @cats = Cats.all
    render 'cat/index'
  end

  def show
    @cat = Cats.find(params[:id])

    @attr = Cats.find(params[:id]).attributes

    render 'cat/show'
  end

  def new
    @cat = Cats.new
    render "cat/new"
  end

  def create
    info = current_user.cats.new(cat_params)

    if info.save
      redirect_to action: "index"
    else
      render plain: "Did not Work Yo"
    end
  end

  def edit
    @cat = Cats.find(params[:id])
    render "cat/edit"
  end

  def update
    @cat = Cats.find(params[:id])

    if @cat.update(cat_params)
      redirect_to "/cat/#{@cat.id}"
    end
  end

  def current_cat
    cat = Cats.find(params[:id])
  end

  def require_own_cat
    if current_user.owns_cat?(current_cat)
      return true
    else
      redirect_to user_url(current_user)
    end
  end

  def cat_params
    params.require(:cat).permit(:name,:sex,:description,:birth_date,:color,:owner_id)
  end

end
