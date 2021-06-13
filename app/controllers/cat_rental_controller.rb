class CatRentalController < ApplicationController
  def index
    @rentals = CatRentals.all.order(:start)
    render "catrental/index"
  end

  def new
    @rental = CatRentals.new
    @cats = Cats.all
    render "catrental/new"
  end

  def create
    @rental = CatRentals.new(cat_rental_params)
    if @rental.save
      redirect_to "/cat"
    else
      render plain: "Did not Work"
    end
  end

  def approved
    @rental = CatRentals.find(params[:id])
    @rental.approve!
    redirect_to "/cat"
  end

  def cat_rental_params
    params.require(:cat_rental).permit(:cat_id,:start,:end,:status)
  end

end
