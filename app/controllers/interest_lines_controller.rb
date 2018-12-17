class InterestLinesController < ApplicationController
  before_action :set_interest_line, only: [:addinterest, :show, :edit, :update, :destroy]

  # GET /interest_lines
  # GET /interest_lines.json
  def index
    @interest_lines = InterestLine.all
  end

  # GET /interest_lines/1
  # GET /interest_lines/1.json
  def show
    if current_user.admin?
     @patriots = @interest_line.patriots.paginate(page: params[:page], per_page: 3).order(created_at: :desc, id: :desc)
       else
      redirect_to root_path, notice: 'You must be an admin to complete this action.'
    end
  end

def getGender(user)
    if user.interest_line.name == "Education"
          return 100000000
        elsif user.interest_line.name == "Health"
          return 100000001
        elsif user.interest_line.name == "Women's Right"
          return 100000002
          elsif user.interest_line.name == "Conflicts and Emergencies"
          return 100000003
          elsif user.interest_line.name == "Food and Agriculture"
          return 100000004

          elsif user.interest_line.name == "Governance"
          return 100000001

        end
end

   def addinterest
    if current_user.patriot?
      current_user.update(interest_line_id: @interest_line.id)

      sexint = getGender(current_user)
        
        client = DynamicsCRM::Client.new({organization_name: ENV['ORG_NAME']})
        client.authenticate(ENV['USER'], ENV['PASSWORD'])
        
        client.update('contact', current_user.crm_id, new_interestline: {type: "OptionSetValue", value: sexint})

      redirect_to root_path, notice: 'You have successfully choosen'+@interest_line.name+'as your Interest Line'
    else
      redirect_to root_path, notice: 'You must be a patriot to complete this action.'
    end
  end

  # GET /interest_lines/new
  def new
    @interest_line = InterestLine.new
  end

  # GET /interest_lines/1/edit
  def edit
  end

  # POST /interest_lines
  # POST /interest_lines.json
  def create
    @interest_line = InterestLine.new(interest_line_params)

    respond_to do |format|
      if @interest_line.save
        format.html { redirect_to @interest_line, notice: 'Interest line was successfully created.' }
        format.json { render :show, status: :created, location: @interest_line }
      else
        format.html { render :new }
        format.json { render json: @interest_line.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /interest_lines/1
  # PATCH/PUT /interest_lines/1.json
  def update
    respond_to do |format|
      if @interest_line.update(interest_line_params)
        format.html { redirect_to @interest_line, notice: 'Interest line was successfully updated.' }
        format.json { render :show, status: :ok, location: @interest_line }
      else
        format.html { render :edit }
        format.json { render json: @interest_line.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /interest_lines/1
  # DELETE /interest_lines/1.json
  def destroy
    @interest_line.destroy
    respond_to do |format|
      format.html { redirect_to interest_lines_url, notice: 'Interest line was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_interest_line
      @interest_line = InterestLine.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def interest_line_params
      params.require(:interest_line).permit!
    end
end
