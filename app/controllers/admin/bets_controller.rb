class Admin::BetsController < ApplicationController
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
      redirect_to current_user
    else
      render :new
    end
  end

  def bet_params
    params.require(:bet).permit(:lock_time, :metric1_attributes=> [:id, :topic], 
                                :metric2_attributes => [:id, :topic]) 
  end


end
