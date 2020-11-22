class ItemsController < ApplicationController
  # ログインしていないユーザーはトップページに促す
  before_action :authenticate_user!, except: :index

  def index
  end
end
