class Api::V1::CommentsController < Api::V1::BaseController
  before_action :set_comment, only: [:download_file, :show, :edit, :update, :destroy]
skip_before_action :verify_authenticity_token
  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new
  end

  # GET /comments/1/edit
  def edit
    
  end

  # POST /comments
  # POST /comments.json
  def create

    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    @comment.commenter_id = @current_user.id
    @comment.commenter_type = @current_user.type
    @comment.save
     render json: @comment, each_serializer: Api::V1::CommentsSerializer
  end

  def post_comments
    @post = Post.find(params[:post_id])
    @comments = @post.comments
    render json: @comments, each_serializer: Api::V1::CommentsSerializer
 
  end
  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to comment_post_path(@comment.post), notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to comment_post_url(@post), notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end



  def download_file
    send_file @comment.attachment.path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit!
    end
end
