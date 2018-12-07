class Api::V1::CollagesController < Api::V1::BaseController
  before_action :set_collage, only: [:show, :edit, :update, :destroy]

  # GET /collages
  # GET /collages.json
  def index
    @collages = Collage.all
     respond_to do |format|
        format.json do
                render json: @collages, each_serializer: Api::V1::CollagesSerializer
        end
      end
  end

  # GET /collages/1
  # GET /collages/1.json
  def show
    render json: @collage, each_serializer: Api::V1::CollagesSerializer
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_collage
      @collage = Collage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def collage_params
      params.require(:collage).permit!
    
    end
    
end
