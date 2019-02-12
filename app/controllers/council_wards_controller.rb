class CouncilWardsController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:new, :create, :show]
  # GET /CouncilWards
  # GET /CouncilWards.json
  def index
    @council_wards = CouncilWard.all
  end

  # GET /CouncilWards/1
  # GET /CouncilWards/1.json
  def show
  end

  # GET /CouncilWards/new
  def new
    @council_ward = CouncilWard.new

  end

  # GET /CouncilWards/1/edit
  def edit
  end

  # POST /CouncilWards
  # POST /CouncilWards.json
  def create
    @council_ward = CouncilWard.new(user_params)

    respond_to do |format|
      if @council_ward.save
        #sign_in(@council_ward)
        format.html { redirect_to @council_ward, notice: 'Your Account was successfully created.' }
        format.json { render :show, status: :created, location: @council_ward }
      else
        format.html { render :new }
        format.json { render json: @council_ward.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /CouncilWards/1
  # PATCH/PUT /CouncilWards/1.json
  def update
    respond_to do |format|
      if @council_ward.update(CouncilWard_params)
        format.html { redirect_to @council_ward, notice: 'Council Ward was successfully updated.' }
        format.json { render :show, status: :ok, location: @council_ward }
      else
        format.html { render :edit }
        format.json { render json: @council_ward.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /CouncilWards/1
  # DELETE /CouncilWards/1.json
  def destroy
    @council_ward.destroy
    respond_to do |format|
      format.html { redirect_to council_wards_url, notice: 'Council Ward was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @council_ward = CouncilWard.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:council_ward).permit(:title, :lga)
    end
end



