class ClientsController < ApplicationController
  before_action :set_client, only: [:show, :edit, :update, :destroy]
  before_action :read_contact_types, only: [:new, :edit]

  # GET /clients
  # GET /clients.json
  def index
    @clients = Client.includes(:address).filter(index_params.slice(:last_name, :first_name, :patronymic)).paginate(:page => params[:page], :per_page => 5)
    
    @return_url = get_session_value(:return_url) || nil
  end
  
  #POST /clients/select_client
  def select
    redirect_url = get_session_value(:return_url).to_s
    #sr = get_session_value(:sr)
    client_id = params[:id]
    if Client.exists?(client_id)
      if get_session_value(:srflag).to_sym == :sender
        set_session_value(:sender, client_id)
      else
	set_session_value(:receiver, client_id)
      end
      set_session_value(:return_url, nil)
      redirect_to redirect_url
      return
    else
      flash[:error] = "Wrong client chosen"
      redirect_to index
    end
  end

  # GET /clients/1
  # GET /clients/1.json
  def show
  end

  # GET /clients/new
  def new
    @client = Client.new
  end

  # GET /clients/1/edit
  def edit
  end

  # POST /clients
  # POST /clients.json
  def create
    @client = Client.new(client_params)

    respond_to do |format|
      if @client.save
        format.html { redirect_to @client, notice: 'Client was successfully created.' }
        format.json { render action: 'show', status: :created, location: @client }
      else
        format.html { render action: 'new' }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clients/1
  # PATCH/PUT /clients/1.json
  def update
    respond_to do |format|
      if @client.update(client_params)
        format.html { redirect_to @client, notice: 'Client was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clients/1
  # DELETE /clients/1.json
  def destroy
    @client.destroy
    respond_to do |format|
      format.html { redirect_to clients_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client
      @client = Client.find(params[:id])
    end

    #reading contact types to use them in dropdown
    def read_contact_types
      @contact_types = ContactType.all
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def client_params
      params.require(:client).permit(:last_name, :first_name, :patronymic, :is_person, address_attributes: [:id, :city, :street, :building, :apartment], contacts_attributes: [:id, :contact_type_id, :value, :_destroy])
    end
    
    #strong_params for index filtering
    def index_params
      params.permit(:last_name, :first_name, :patronymic)
    end
    
end
