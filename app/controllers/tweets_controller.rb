class TweetsController < ApplicationController
  before_action :set_user, only: [:show, :new, :create, :edit, :update, :destroy, :tweet_list_partial]
  before_action :set_tweet, only: [:show, :edit, :update, :destroy]

  def tweet_list_partial
    render partial: 'tweet_list_partial', locals: { user: @user }
  end

  # GET /search
  def search_partial
    options = {
      time: Time.now.to_i,
      limit: Tweet::DEFAULT_LIST_COUNT,
      offset: 0
    }

    options[:time] = params[:time].to_i if params[:time].present?
    options[:user_id] = params[:user_id].to_i if params[:user_id].present?
    options[:offset] = params[:offset].to_i if params[:offset].present?

    render partial: 'search_partial', locals: { tweets: Tweet.search(options), options: options }
  end

  def show
  end

  def new
    @tweet = Tweet.new
  end

  def edit
  end

  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user = @user
    from_path = params[:tweet][:from_path] if params[:tweet][:from_path]

    if @tweet.save
      if from_path.present?
        redirect_to from_path, notice: 'Tweet was successfully created.'
      else
        redirect_to user_tweet_path(@user, @tweet), notice: 'Tweet was successfully created.'
      end
    else
      render :new
    end
  end

  def update
    from_path = params[:tweet][:from_path] if params[:tweet][:from_path]
    if @tweet.update(tweet_params)
      if from_path.present?
        redirect_to from_path, notice: 'Tweet was successfully updated.'
      else
        redirect_to user_tweet_path(@user, @tweet), notice: 'Tweet was successfully updated.'
      end
    else
      render :edit
    end
  end

  def destroy
    from_path = params[:tweet][:from_path] if params[:tweet][:from_path]
    @tweet.destroy
    if from_path.present?
      redirect_to from_path, notice: 'Tweet was successfully destroyed.'
    else
      redirect_to user_path(@user), notice: 'Tweet was successfully destroyed.'
    end
  end

  private

    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    def set_user
      @user = User.find(params[:user_id])
    end

    def tweet_params
      params.require(:tweet).permit(:user_id, :content)
    end
end
