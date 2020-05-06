class RelationshipsController < ApplicationController
	# followingとfollowerに関してはset_userの対象外とする
	before_action :set_user,except: [:following, :follower, :userfollower, :userfollowing]

	# def following
	# 	#current_userのフォローを知りたい
	# 	@followings = current_user.followings
	# 	@book = Book.new
	# end

	# def follower
	# 	#current_userのフォロワーを知りたい
	# 	@followers = current_user.followers
	# 	@book = Book.new
	# end

	def userfollower
		#@userでユーザの情報レコードを取り出す
		@user = User.find(params[:id])
		#取得したユーザーのフォロワーを結びつける
		@followers = @user.followers
		#render ビューを呼び出すのみ、「例えば、follower.html.erbのビューを呼び出すだけ」
		#redirect_to ルーティングからコントローラのアクションの情報を呼び出す
		#仮にrenderを書かずに行くとなると、アクション名である[userfollower.html.erb]を呼び出す事をする。
		render :follower
	end

	def userfollowing
		@user = User.find(params[:id])
		#取得したユーザのフォローを結びつける
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
