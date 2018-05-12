class UserController < ApplicationController
  before_action :ensure_login, except: [:index,:signup,:login]
  before_action :correct_user, only: [:update, :pass_change, :destroy]
  def index
    @users = User.all

  end

  def signup
    @user = User.new(
      name: params[:name],
      email: params[:email],
      password: params[:password],
      image_name: "default_user.jpg")
    key_user = User.find_by(id:1)
    if key_user.authenticate(params[:keyword])
      if @user.save
        flash[:notice] = "登録完了！"
        session[:user_id] = @user.id
        redirect_to("/")
      end
    else
      flash[:notice] = "Keywordが正しくありません"
      redirect_to("/")
    end
  end

  def login
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      flash[:notice] = "ログイン完了!"
      session[:user_id] = @user.id
      redirect_to("/")
    else
      flash[:notice] = "ログインに失敗しました"
      redirect_to("/")
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to("/")
  end

  def show
    @user = User.find_by(id:params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    @user.email = params[:email]
    if params[:image]
      image = params[:image]
      @user.image_name = "#{@user.id}.jpg"
      File.binwrite("public/user_image/#{@user.image_name}", image.read)
    end
    if @user.save
      flash[:notice] = "プロフィール変更完了！"
      redirect_to("/user/#{@user.id}")
    else
      render("user/#{@user.id}")
    end
  end

  def pass_change
    @user = User.find_by(id: params[:id])
    if @user.authenticate(params[:former_password])
      @user.password = params[:new_password]
      if @user.save
        flash[:notice] = "パスワードの変更が完了しました"
        redirect_to("/user/#{@user.id}")
      else
        flash[:notice] = "パスワードの変更が失敗しました"
        redirect_to("/user/#{@user.id}")
      end
    else
      flash[:notice] = "旧パスワードが正しくありません"
      redirect_to("/user/#{@user.id}")
    end
  end

  def destroy
    @user = User.find_by(id: params[:id])
    if @user.destroy
      flash[:notice] = "ユーザーが削除されました"
      session[:user_id] = nil
      redirect_to("/")
    else
      flash[:notice] = "ユーザー削除に失敗しました"
      redirect_to("/user/#{@user.id}")
    end
  end

  def ensure_login
    if @current_user == nil
      flash[:notice] = "ログインが必要です"
      redirect_to("/")
    end
  end

  def correct_user
    @user = User.find_by(id: params[:id])
    if @user.id != @current_user.id
      flash[:notice] = "権限がありません"
      redirect_to("/user/index")
    end
  end

end
