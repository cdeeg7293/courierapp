class CouriersController < ApplicationController
  before_action :set_courier, only: [:show, :edit, :update, :destroy]

  # GET /couriers
  # GET /couriers.json
  def index
    @couriers = Courier.paginate(:page => params[:page], :per_page => 15)
  end

  # GET /couriers/1
  # GET /couriers/1.json
  def show
  end

  # GET /couriers/new
  def new
    @courier = Courier.new
  end

  # GET /couriers/1/edit
  def edit
  end

  # POST /couriers
  # POST /couriers.json
  def create
    @courier = Courier.new(courier_params)
    
    logger.debug(courier_params.inspect)
    logger.debug(@courier.inspect)

    respond_to do |format|
      if @courier.save
        format.html { redirect_to @courier, notice: 'Courier was successfully created.' }
        format.json { render action: 'show', status: :created, location: @courier }
      else
        format.html { render action: 'new' }
        format.json { render json: @courier.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /couriers/1
  # PATCH/PUT /couriers/1.json
  def update
    respond_to do |format|
      if @courier.update(courier_params)
        format.html { redirect_to @courier, notice: 'Courier was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @courier.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /couriers/1
  # DELETE /couriers/1.json
  def destroy
    @courier.destroy
    respond_to do |format|
      format.html { redirect_to couriers_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_courier
      @courier = Courier.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def courier_params
      params.require(:courier).permit(client_attributes: [:id, :last_name, :first_name, :patronymic, address_attributes: [:id, :city, :street, :building, :apartment], contacts_attributes: [:id, :contact_type_id, :value, :_destroy] ], address_attributes: [:id, :city, :street, :building, :apartment])
    end
end
