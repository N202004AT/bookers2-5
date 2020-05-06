class RelationshipsController < ApplicationController
	# followingとfollowerに関してはset_userの対象外とする
	before_action :set_user,except: [:following, :follower, :userfollower, :userfollowing]

	def following
		#current_userのフォローを知りたい
		@followings = current_user.followings
		@book = Book.new
	end

	def follower
		#current_userのフォロワーを知りたい
		@followers = current_user.followers
		@book = Book.new
	end

	def userfollower
		@user = User.find(params[:id])
		@followers = @user.followers
		render :follower
	end

	def userfollowing
		@user = User.find(params[:id])
		@followings = @user.followings
		render :following
	end

	def create
		following = current_user.follow(@user)
		if following.save
			flash[:success] = 'フォローしました'
			redirect_to request.referer
		else
			flash.now[:alert] = 'フォローに失敗しました'
			redirect_to request.referer
		end
	end

	def destroy
		following = current_user.unfollow(@user)
		if following.destroy
			flash[:success] = '解除しました'
			redirect_to request.referer
		else
			flash.now[:alert] = '解除に失敗しました'
			redirect_to request.referer
		end
	end

	private
	def set_user
		@user = User.find(params[:follow_id])
	end
end
