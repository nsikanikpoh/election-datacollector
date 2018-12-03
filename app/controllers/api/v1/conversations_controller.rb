class ConversationsController < ApplicationController
  before_action :set_conversation, only: [:show, :edit, :update, :destroy]

 
  # GET /conversations/1
  # GET /conversations/1.json
  def show
  end

  # GET /conversations/1/edit
  def edit
  end
  

 def fundraiser_conversations
    @fundraiser = @current_user
    @conversations = @fundraiser.conversations
    render json: @conversations, each_serializer: Api::V1::ConversationsSerializer
 end

 def prospect_comments
    @post = Prospect.find(params[:pros_id])
    @comments = @post.conversations
     render json: @conversations, each_serializer: Api::V1::ConversationsSerializer
 
  end


  # POST /conversations
  # POST /conversations.json
  def create
    @fundraiser = @current_user
    @prospect = Prospect.find(params[:pros_id])
    @conversation = @fundraiser.conversations.create(conversation_params)
    @conversation.commenter_id =  @prospect.id
    @conversation.commenter_type = @prospect.type
    @conversation.save
    render json: @conversation, each_serializer: Api::V1::ConversationsSerializer
  end

  # PATCH/PUT /conversations/1
  # PATCH/PUT /conversations/1.json
  def update
    respond_to do |format|
      if @conversation.update(conversation_params)
        format.html { redirect_to @conversation, notice: 'Conversation was successfully updated.' }
        format.json { render json: @conversation, each_serializer: Api::V1::ConversationsSerializer }
      else
        format.html { render :edit }
        format.json { render json: @conversation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /conversations/1
  # DELETE /conversations/1.json
  def destroy
    @conversation.destroy
    respond_to do |format|
      format.html { redirect_to conversations_url, notice: 'Conversation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_conversation
      @conversation = Conversation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def conversation_params
      params.require(:conversation).permit!
    end
end
