class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :load_sender_and_receiver, only: [:new, :edit]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.includes(:sender, :receiver).paginate(:page => params[:page], :per_page => 15)
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render action: 'show', status: :created, location: @order }
      else
        format.html { render action: 'new' }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url }
      format.json { head :no_content }
    end
  end
  
  def select_sender_or_receiver
    set_session_value(:return_url, URI(request.referer).path) #need to make this more modern!
    set_session_value(:srflag, params[:srflag])
    redirect_to clients_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:sender_id, :receiver_id, :sum, :delivered_date)
    end
    
    def load_sender_and_receiver
      sender_id = get_session_value(:sender)
      if sender_id 
	@sender = Client.find(sender_id)
      end
      
      receiver_id = get_session_value(:receiver)
      if receiver_id 
	@receiver = Client.find(receiver_id)
      end
    end
end
