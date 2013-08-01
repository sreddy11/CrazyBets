class Admin::BetsController < ApplicationController
  
  before_filter :must_be_admin
  before_filter :bet_not_started, :only => [:edit, :update, :destroy]

  def new
    @bet = Bet.new
    @bet.build_metric1
    @bet.build_metric2
  end

  def show
  end

  def edit
    @bet = Bet.find(params[:id])
  end

  def update
    @bet = Bet.find(params[:id])
    if @bet.update(bet_params)
      redirect_to current_user, :notice => "Bet resolved"
    else
      render :edit
    end
  end

  def destroy
    @bet = Bet.find(params[:id])
    if @bet.destroy
      flash[:notice] = "Bet deleted"
    else
      flash[:notice] = "Ooops something went wrong! Bet was not deleted"
    end
    redirect_to current_user
  end


  def create
    @bet = Bet.new(bet_params)
    if @bet.save
      redirect_to current_user, :notice => "Bet Created"
    else
      render :new
    end
  end

  def bet_params
    params.require(:bet).permit(:lock_time, :metric1_attributes=> [:id, :topic], 
                                :metric2_attributes => [:id, :topic]) 
  end

  private

  def must_be_admin
    unless session[:user_type] == "admin" 
      flash[:error] = " Unauthorized access"
      redirect_to(root_url)
    end 
  end
end
