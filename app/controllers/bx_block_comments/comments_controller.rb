module BxBlockComments
  class CommentsController < ApplicationController
    include BuilderJsonWebToken::JsonWebTokenValidation
    before_action :validate_json_web_token
    before_action :validate_params, only: [:create, :update]

    def index

      @comments = Comment.where('account_id = ?', @token.id)
          if params[:query].present?
            @comments = @comments.where('comment LIKE :search', search: "%#{params[:query]}%")
          end
		  if @comments.present?
			  	render json: CommentSerializer.new(@comments, meta: {message: 'List of comments created by user.'
				 }).serializable_hash, status: :ok
		  else
			  	render json: {errors: [
				 	{message: 'No comments.'},
				 	]}, status: :ok 
		  end
    end
    
    def show
			@comment = Comment.find(params[:id])
            if @comment.present?
                render json: CommentSerializer.new(@comment, 
                    meta: {success: true, message: "Comment details."
                    }).serializable_hash, status: :ok
            else
                render json: {errors: [
                    {success: false, message: "Comment does not exist."},
                    ]}, status: :ok
            end
    end

    def create
      comment_params = jsonapi_deserialize(params)
      @comment = Comment.new(comment_params)
      @comment.account_id = @token.id
      if @comment.save
        render json: CommentSerializer.new(@comment, meta: {
            message: "Comment created."}).serializable_hash, status: :created
      else
        render json: {errors: format_activerecord_errors(@comment.errors)},
          status: :unprocessable_entity
      end
    end


    def update
        @comment = Comment.find_by(id: params[:id], account_id: @token.id)
        return render json: {errors: [
         {message: 'Comment does not exist.'},
          ]}, status: :unprocessable_entity if !@comment.present?
        comment_params = jsonapi_deserialize(params)
        if @comment.update(comment: comment_params["comment"])
            render json: CommentSerializer.new(@comment, meta: {
        message: "Comment updated."}).serializable_hash, status: :ok
        else
            render json: {errors: format_activerecord_errors(@comment.errors)},
                status: :unprocessable_entity
        end
    end

    def destroy
        @comment = Comment.find_by(id: params[:id], account_id: @token.id)
        return render json: {errors: [
        {message: 'Comment does not exist.'},
          ]}, status: :unprocessable_entity if !@comment.present?
        if @comment.destroy
            render json: { message: "Comment deleted."}, status: :ok
        else
            render json: {errors: format_activerecord_errors(@comment.errors)},
                status: :unprocessable_entity
        end
    end

    private

    def validate_params
    	return render json: {errors: [
					{message: 'Parameter missing.'},
			]}, status: :unprocessable_entity if params[:data][:attributes][:post_id].blank? || params[:data][:attributes][:comment].blank?
    end

  end
end
