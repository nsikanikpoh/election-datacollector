class Api::V1::InterestLinesController < Api::V1::BaseController
  before_action :set_interest_line, only: [:addinterest, :show, :edit, :update, :destroy]

  # GET /interest_lines
  # GET /interest_lines.json
  def index
    @interest_lines = InterestLine.all
     render json: @interest_lines, each_serializer: Api::V1::InterestLineSerializer
  end

  # GET /interest_lines/1
  # GET /interest_lines/1.json
  def show
       render json: @interest_line, each_serializer: Api::V1::InterestLineSerializer
  end

  # GET /interest_lines/new
 
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
          return 100000005

        end
end

  def addinterest
      @current_user.update(interest_line_id: @interest_line.id)
      sexint = getGender(@current_user)
        
        client = DynamicsCRM::Client.new({organization_name: ENV['ORG_NAME']})
        client.authenticate(ENV['USER'], ENV['PASSWORD'])
        
        client.update('contact', current_user.crm_id, new_interestline: {type: "OptionSetValue", value: sexint})

      render json: @current_user, serializer: Api::V1::PatriotsSerializer,  status: :created  
 end


 def myinterest
  @interest_line = @current_user.interest_line
  render json: @interest_line, each_serializer: Api::V1::InterestLineSerializer
 end

  # GET /interest_lines/1/edit
  def edit
  end

  # POST /interest_lines
  # POST /interest_lines.json
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_interest_line
      @interest_line = InterestLine.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def interest_line_params
      params.require(:interest_line).permit(:name, :description)
    end
end
