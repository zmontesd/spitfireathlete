class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    @exercises = @user.exercises  
    @microposts = @user.microposts
    @micropost = @user.microposts.build

    @commentable = @user
    @comments = @commentable.comments
    @comment = Comment.new

    @feed = @user.feed
    feed = @user.feed

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new
    exercise = @user.exercises.build
    micropost = @user.microposts.build
    feed = @user.feed
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = current_resource
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    #Authentication
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user, notice: "Welcome, Spitfire!" and return
    else
      render "new", notice: "Don't forget to upload an image of you!" and return
    end

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = current_resource

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = current_resource
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

private
  def current_resource
    @current_resource ||= User.find(params[:id]) if params[:id]
  end

end
