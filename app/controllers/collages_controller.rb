class CollagesController < ApplicationController
  before_action :set_collage, only: [:show, :edit, :update, :destroy]

  # GET /collages
  # GET /collages.json
  def index
    @collages = Collage.all
  end

  # GET /collages/1
  # GET /collages/1.json
  def show
  end

  # GET /collages/new
  def new
    @collage = Collage.new
  end

  # GET /collages/1/edit
  def edit
  end

  # POST /collages
  # POST /collages.json
  def create
    params.permit!
    @collage = Collage.create(collage_params)
    @collage.save
    if @collage.save
      convert_params
    end
    
    respond_to do |format|
      if @collage.save
        format.html { redirect_to @collage, notice: 'Collage was successfully created.' }
        format.json { render :show, status: :created, location: @collage }
      else
        format.html { render :new }
        format.json { render json: @collage.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /collages/1
  # PATCH/PUT /collages/1.json
  def update
    respond_to do |format|
      if @collage.update(collage_params)
        format.html { redirect_to @collage, notice: 'Collage was successfully updated.' }
        format.json { render :show, status: :ok, location: @collage }
      else
        format.html { render :edit }
        format.json { render json: @collage.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /collages/1
  # DELETE /collages/1.json
  def destroy
    @collage.destroy
    respond_to do |format|
      format.html { redirect_to collages_url, notice: 'Collage was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_collage
      @collage = Collage.find(params[:id])
    end


    def convert_params
    unless params[:collage][:pics_attributes].blank?
      params[:collage][:pics_attributes].each do |key, pic_attributes|
          pic = Pic.create(picture: pic_attributes[:picture], collage_id: @collage.id)
           
        end
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def collage_params
      params.require(:collage).permit(:title, :pics_attributes, pic_attributes:[:picture,:_destroy])
    
    end
    
end
