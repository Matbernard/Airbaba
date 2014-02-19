class BookingsController < ApplicationController
  before_action :set_flat
  before_action :set_booking, only: [:show, :edit, :update, :destroy]

  # GET /bookings
  # GET /bookings.json
  def index
    @bookings = Booking.all
  end

  # GET /bookings/1
  # GET /bookings/1.json
  def show
    @flat = Flat.find(params[:flat_id])
    @booking = Booking.find(params[:id])
  end

  # GET /bookings/new
  def new
    @booking = Booking.new # (flat_id: params[:flat_id])
    @flat = Flat.find(params[:flat_id])
  end

  # GET /bookings/1/edit
  def edit
  end

  # POST /bookings
  # POST /bookings.json
  def create  
    @booking = current_user.bookings.create(booking_params.merge(flat: @flat))    

    respond_to do |format|
      if @booking.save
        format.html { redirect_to [@flat, @booking], notice: 'Booking was successfully created.' }
        format.json { render action: 'show', status: :created, location: @booking }
      else
        format.html { render action: 'new' }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bookings/1
  # PATCH/PUT /bookings/1.json
  def update
    respond_to do |format|
      if @booking.update(booking_params)
        format.html { redirect_to @flat, @booking, notice: 'Booking was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bookings/1
  # DELETE /bookings/1.json
  def destroy
    @booking.destroy
    respond_to do |format|
      format.html { redirect_to bookings_url }
      format.json { head :no_content }
    end
  end


  private
    def set_flat
      @flat = Flat.find(params[:flat_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_booking
      @booking = Booking.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def booking_params
      params.require(:booking).permit(:start_date, :end_time, :flat_id, :booker_id)
    end

end
