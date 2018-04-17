class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  respond_to :json, only: [:create, :destroy, :update]

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = @post.comments.create(comment_params)
    binding.pry
    render json: { comment: @comment}
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    @comment.update(comment_params)
    respond_with(@post, @comment)
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_with(@post, @comment)
  end

  private

    def authorize_comment
      authorize @comment
    end

    def set_post
      @post = Post.find(params[:post_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = @post.comments.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:body).merge(user_id: current_user.id)
    end
end
