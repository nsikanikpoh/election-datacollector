class Api::V1::PicsController <  Api::V1::BaseController
 # before_action :set_pic, only: [:download_file, :show, :edit, :update, :destroy]

  # GET /pics
  # GET /pics.json


  def collage_comments
    @collage = Collage.find(params[:collage_id])
    @pics = @collage.pics
    render json: @pics, each_serializer: Api::V1::PicsSerializer
  end

  # GET /pics/new


  # POST /pics
  # POST /pics.json
 

  private
    # Use callbacks to share common setup or constraints between actions.
   
    # Never trust parameters from the scary internet, only allow the white list through.
    def pic_params
      params.require(:pic).permit(:picture)
    end
end
