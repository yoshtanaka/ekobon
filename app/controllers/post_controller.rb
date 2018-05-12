class PostController < ApplicationController
  before_action :ensure_login, except: :index

  def show
    @post = Post.find_by(id: params[:id])
  end

  def index
    @posts = Post.all.order('id DESC')
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    if @post.destroy
      flash[:notice] = "投稿を削除しました"
      redirect_to("/post/index")
    else
      flash[:notice] = "削除に失敗しました"
      redirect_to("/post/index")
    end
  end

  def new_post
    @post = Post.new(
      user_id: @current_user.id,
      contents: params[:post_content]
    )
    if @post.save
      if params[:post_image]
        @post.post_image = "#{@post.id}.jpg"
        image = params[:post_image]
        File.binwrite("public/post_image/#{@post.post_image}", image.read)
        @post.save
      end
      flash[:notice] = "投稿完了!"
      redirect_to("/")
    else
      flash[:notice] = "投稿が失敗しました"
      redirect_to("/")
    end
  end

  def ensure_login
    if @current_user == nil
      flash[:notice] = "ログインが必要です"
      redirect_to("/")
    end
  end

end
