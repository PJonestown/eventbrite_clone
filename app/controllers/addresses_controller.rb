class AddressesController < ApplicationController
  before_action :set_address, only: [:show, :edit, :update, :destroy]
  before_action :users_only, except: [:index, :show]

  def index
    @addressable = find_addressable
    @addresses = @addressable.address
  end

  def show
  end

  def new
    @addressable = find_addressable
    @address = Address.new
  end

  def edit
  end

  def create
    @addressable = find_addressable
    @address = @addressable.build_address(address_params)

    respond_to do |format|
      if @address.save
        format.html { redirect_to @addressable, notice: 'Address was successfully created.' }
        format.json { render :show, status: :created, location: @address }
      else
        format.html { render :new }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @addressable = find_addressable
    respond_to do |format|
      if @address.update(address_params)
        format.html { redirect_to @address, notice: 'Address was successfully updated.' }
        format.json { render :show, status: :ok, location: @address }
      else
        format.html { render :edit }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @address.destroy
    respond_to do |format|
      format.html { redirect_to addresses_url, notice: 'Address was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_address
      @address = Address.find(params[:id])
    end

    def address_params
      params.require(:address).permit(:location, :latitude, :longitude, :addressable_id, :addressable_type)
    end

    def find_addressable
      params.each do |name, value|
        if name =~ /(.+).id$/
          return $1.classify.constantize.find(value)
        end
      end
    end

    def users_only
      redirect_to sign_in_path unless signed_in?
    end
end
