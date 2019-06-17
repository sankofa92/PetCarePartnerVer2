class OrdersController < ApplicationController
  before_action :authenticate_user!
  def index
    @orders = current_user.orders.all
  end

  def new
    @order = Order.new
    @booking_date = BookingDate.new
    @sitter = session[:current_sitter].to_h
    @drop = Date.strptime(session[:drop_off], '%m/%d/%Y')
    @pick = Date.strptime(session[:pick_up], '%m/%d/%Y')
    @total = (@pick - @drop).to_i * @sitter['price']
  end
  
  def create
    @order = Order.new(order_params)
    @sitter = session[:current_sitter].to_h
    @drop = Date.strptime(session[:drop_off], '%m/%d/%Y')
    @pick = Date.strptime(session[:pick_up], '%m/%d/%Y')
    
    # @booking_date = BookingDate.new
    @booking_date_drop = BookingDate.new
    @booking_date_pick = BookingDate.new
    #@pick - @drop 剩餘天數
    #迴圈跑剩餘天數
    #[].push {date: @drop+1}

    if @order.save
      # @booking_date.update(sitter_id: @sitter['id'])
      @booking_date_drop.update(sitter_id: @sitter['id'], date: @drop, available: false)
      @booking_date_pick.update(sitter_id: @sitter['id'], date: @pick, available: false)
      
      # BookingDate.where(sitter_id: @sitter['id']).update(date: @drop..@pick, :available => false)
      redirect_to user_orders_path, notice:'成功下訂！'
    else
      render :new
    end
  end

  def show
    @order = current_user.orders.find_by(id: params[:id])
  end
  
  def pending
    @orders = current_user.orders.where(status: 'pending')
  end
  
  def finish
    @orders = current_user.orders.where(status: 'paid')
  end
  
  def cancel
    @orders = current_user.orders.where(status: 'cancel')
  end

  private
  def order_params
    params.require(:order).permit(:user_id, :sitter_id, :drop_off, :pick_up, :status, :note)
  end
  # def booking_date_params
  #   params.require(:booking_date).permit(:sitter_id, :date, :avaliable)
  # end
end
