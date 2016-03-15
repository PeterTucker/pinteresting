# CREATE = new + create 
# READ = show
# UPDATE = edit + update
# DELETE = destroy
# index is showing a list of all pins
# 7 Actions in all

class PinsController < ApplicationController
  before_action :set_pin, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show] # User must be authenticated to run actions, except viewing via seeing the entire pin list and individual pins via show.
  # GET /pins
  # GET /pins.json
  def index
    @pins = Pin.all
  end

  # GET /pins/1
  # GET /pins/1.json
  def show
  end

  # GET /pins/new
  # Shows page for actually creating a pin. Once submitted it links to the 'create'(POST) action.
  def new
    @pin = current_user.pins.build # Creates a new pin which als has a user associated as opposed to Pin.new
  end

  # GET /pins/1/edit
  def edit
  end

  # POST /pins
  # POST /pins.json
  # Actually create the pin as opposed to serving the create pin page('new' action)
  def create
    @pin = current_user.pins.build(pin_params)

      if @pin.save
        redirect_to @pin, notice: 'Pin was successfully created.'
      else
        render :new 
      end
  end

  # PATCH/PUT /pins/1
  # PATCH/PUT /pins/1.json
  def update
      if @pin.update(pin_params)
        redirect_to @pin, notice: 'Pin was successfully updated.' 
      else
        render :edit 
      end
  end

  # DELETE /pins/1
  # DELETE /pins/1.json
  def destroy
    @pin.destroy
    redirect_to pins_url
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pin
      @pin = Pin.find(params[:id])
    end
    
    def correct_user
      if user_signed_in?
      @pin = current_user.pins.find_by(id: params[:id])
      redirect_to pins_path, notice: "You are not Authorized to edit this pin." if @pin.nil?
      else
      redirect_to pins_path, notice: "Sign in to edit a pin."
      end
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def pin_params
      params.require(:pin).permit(:description)
    end
end
