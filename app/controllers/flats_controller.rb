class FlatsController < ApplicationController
  before_action :set_flat, only: [:show, :edit, :update, :destroy]
  skip_before_filter :authenticate_user!, :only => [:index, :show]
  after_action :build_pictures, except: [:index, :show, :destroy]


  # GET /flats
  # GET /flats.json
  def index
    if params.has_key?(:flat)
      search = params[:flat]
      @flats = Flat.with_city(search[:city]).available(search[:start_date], search[:end_time])
    else
      @flats = Flat.all
    end
  end

  # GET /flats/1
  # GET /flats/1.json
  def show
    @review = Review.new
  end

  # GET /flats/new
  def new
    @flat = Flat.new
    build_pictures
  end

  # GET /flats/1/edit
  def edit
    unless @flat.belongs_to?(current_user)
      redirect_to root_path, alert: "This is not your flat !"
    end 
    build_pictures
  end

  # POST /flats
  # POST /flats.json
  def create
    @flat = current_user.flats.build(flat_params)

    respond_to do |format|
      if @flat.save
        format.html { redirect_to flat_url(@flat), notice: 'Flat was successfully created.' }
        format.json { head :no_content }
      else
        build_pictures
        format.html { render action: 'new' }
        format.json { render json: @flat.errors, status: :unprocessable_entity }
      end

    end
  end

  # PATCH/PUT /flats/1
  # PATCH/PUT /flats/1.json
  def update
    respond_to do |format|
      if @flat.update(flat_params)
        format.html { redirect_to @flat, notice: 'Flat was successfully updated.' }
        format.json { head :no_content }
      else
        build_pictures
        format.html { render action: 'edit' }
        format.json { render json: @flat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /flats/1
  # DELETE /flats/1.json
  def destroy
    @flat.destroy
    respond_to do |format|
      format.html { redirect_to flats_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_flat
      @flat = Flat.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def flat_params
      params.require(:flat).permit(:title, :address, :day_price, :description, :city, :owner_id, pictures_attributes: [:id, :picture], tag_ids:[])
    end

    def build_pictures
      @picture = @flat.pictures.build
    end


end
