class PollingUnitsController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:new, :create, :show]
  # GET /users
  # GET /users.json
  def index
    @polling_units = PollingUnit.all
  end


  # GET /users/1
  # GET /users/1.json
  def show
  end
  


  # GET /users/new
  def new
    @polling_unit = PollingUnit.new

  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @polling_unit = PollingUnit.new(user_params)

    respond_to do |format|
      if @polling_unit.save
        format.html { redirect_to @polling_unit, notice: 'Polling Unit was successfully created.' }
        format.json { render :show, status: :created, location: @polling_unit }
      else
        format.html { render :new }
        format.json { render json: @polling_unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @polling_unit.update(user_params)
        format.html { redirect_to @polling_unit, notice: 'Polling Unit successfully updated.' }
        format.json { render :show, status: :ok, location: @polling_unit }
      else
        format.html { render :edit }
        format.json { render json: @polling_unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @polling_unit.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'Unit was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @polling_unit = PollingUnit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:polling_unit).permit(:title, :lga)
    end
end



