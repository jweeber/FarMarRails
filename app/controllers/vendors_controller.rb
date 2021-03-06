class VendorsController < ApplicationController

  def index
    @vendors = Vendor.uniq.order(name: :asc)
  end

  def show
    @vendors = Vendor.where(id: params[:id])
  end

  def new
    @vendor = Vendor.new 
    if @vendor.market_id
      @current_market = @vendor.market.id
    end
  end

  def create
    @market = Market.where(id: params[:vendor][:market_id]).first
    @vendor = Vendor.create(vendor_create_params[:vendor])
    if @vendor
      redirect_to market_path(id: @market.id)
    else
      render :new
    end
  end

  def edit
    @vendor = Vendor.find(params[:id])
    if @vendor.id
      @current_market = @vendor.market.id
    end
    render :new
  end

  def update
    @vendor = Vendor.find(params[:id])
    @vendor.update_attributes(vendor_update_params[:vendor])
    redirect_to markets_path
  end

  def destroy
    @vendors = Vendor.find(params[:id])
    @market = Market.find(@vendors.market_id)
    @vendors.destroy
    redirect_to market_path(@market)
  end

  private

  def vendor_create_params
    params.permit(vendor: [:name, :employee_count, :market_id])
  end

  def vendor_update_params
    params.permit(vendor: [:name, :employee_count, :market_id])
  end

end
