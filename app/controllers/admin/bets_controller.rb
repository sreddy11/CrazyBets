class Admin::BetsController < ApplicationController
  
  before_filter :must_be_admin

  def new
    @bet = Bet.new
    @bet.build_metric1
    @bet.build_metric2
  end

  def show
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
