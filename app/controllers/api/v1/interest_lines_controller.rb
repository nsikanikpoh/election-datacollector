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
 

  def addinterest
      @current_user.update(interest_line_id: @interest_line.id)
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
