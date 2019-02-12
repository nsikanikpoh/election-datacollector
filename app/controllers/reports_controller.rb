class ReportsController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:new, :create, :show]
  # GET /users
  # GET /users.json
  def index
    @reports = Report.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @report = Report.new
    @council_wards = CouncilWard.all
    @polling_units = PollingUnit.all
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @report = Report.new(user_params)
    @report.user = current_user
    respond_to do |format|
      if @report.save
        format.html { redirect_to @report, notice: 'Report was successfully created.' }
        format.json { render :show, status: :created, location: @report }
      else
        format.html { render :new }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @report.update(user_params)
        format.html { redirect_to @report, notice: 'Report successfully updated.' }
        format.json { render :show, status: :ok, location: @report }
      else
        format.html { render :edit }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @report.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'Report was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @report = Report.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:report).permit(:election_type, :user_id, :lga, :council_ward_id, :polling_unit_id, :arrival_time, :arrival_election_material, :voting_started, :voting_ended, :all_voters, :valid_voters, :invalid_voters, :apc_votes, :apga_votes, :labour_party, :pdp_votes, :prp_votes, :ypp_votes, :total_votes, :result_time, :pdp_agent, :agent_phone, :officer_name, :officer_gender, :picture, :remove_picture, :picture_cache, :sheet, :remove_sheet, :sheet_cache, :latitude, :longitude)
    end
end



