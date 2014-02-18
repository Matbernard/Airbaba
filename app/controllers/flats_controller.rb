class FlatsController < ApplicationController
  before_action :set_flat, only: [:show, :edit, :update, :destroy]

  # GET /flats
  # GET /flats.json
  def index
    @flats = Flat.all
  end

  # GET /flats/1
  # GET /flats/1.json
  def show
  end

  # GET /flats/new
  def new
    @flat = Flat.new
    @pictures = @flat.pictures.build
  end

  # GET /flats/1/edit
  def edit
    if @flat.owner != current_user
      redirect_to root_path, alert: "This is not your flat!"
      return
    end
    @flat.build_picture if @flat.pictures.nil?
    @flat = Flat.find(params[:id])
    @pictures = @flat.pictures
  end

  # POST /flats
  # POST /flats.json
  def create
    @flat = current_user.flats.create(flat_params)
    redirect_to flat_url(@flat)
  end

  # PATCH/PUT /flats/1
  # PATCH/PUT /flats/1.json
  def update
    respond_to do |format|
      if @flat.update(flat_params)
        format.html { redirect_to @flat, notice: 'Flat was successfully updated.' }
        format.json { head :no_content }
      else
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
      params.require(:flat).permit(:title, :address, :day_price, :description, :owner_id, pictures_attributes: [:id, :picture], tag_ids:[])
    end


end
