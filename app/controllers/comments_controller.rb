class CommentsController < ApplicationController
	after_action :comments_count, only: [:create, :destroy]

	http_basic_authenticate_with name: 'khanh', password: 'hang', only: :destroy

	def create
		@article = Article.find(params[:article_id])
		@comment = @article.comments.create(comment_params)
		redirect_to article_path(@article)
	end

	def destroy
		@article = Article.find(params[:article_id])
		@comment = @article.comments.find(params[:id])
		@comment.destroy
		redirect_to article_path(@article)
		
	end

	private

	def comment_params
		params.require(:comment).permit(:commenter, :body)
	end 

	def comments_count
	 	
	 	Article.all.each do |a|
	 		a.update(comments_count: a.comments.size)
	 	end
	end 	 

end
