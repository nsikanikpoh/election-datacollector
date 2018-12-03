class Api::V1::MembersController < Api::V1::BaseController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  
  # GET /users
  # GET /users.json
  def index
    @users = User.all
    respond_to do |format|
      format.json{render :json => @users.to_json, :status => :ok }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
      respond_to do |format|
      format.json{render :json => @user.to_json, :status => :ok }
    end
  end

  # POST /users
  # POST /users.json
def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        code = @user.id + 24523009
        @user.update(affiliate_code: code)
        format.json{render :json => @user.to_json, :status => :ok, location: [:api, @user]}
       else
         format.json { render json: @user.errors, status: :unprocessable_entity }
       end
    end
end
  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.json{render :json => @user.to_json, :status => :ok, location: [:api, @user]}
       else
         format.json { render json: @user.errors, status: :unprocessable_entity }
       end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
     format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:member).permit(:api_token, :referrer_code, :affiliate_code, :name, :birthday, :image, :remove_image, :image_cache, :title, :gender, :phone, :type, :address, :location, :state, :email, :password, :remember_me)
    end
end
