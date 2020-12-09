class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @order_form = OrderForm.new
    # item_idを指定することで、マイグレーションファイルに対応して、リファレンス(参照)され、itemsテーブルにあるデータを取得できる
    # リファレンスでは無くintegerとしていた場合には、キーを全て指定する必要が出てくる
    @item = Item.find(params[:item_id])
    redirect_to root_path if current_user.id == @item.user_id
  end

  def create
    @order_form = OrderForm.new(order_params)
    # itemがあっての、order_form（入れ子構造）。他のコントローラーで生成されたitemを使うにはcreateアクションに定義する。
    @item = Item.find(params[:item_id])
    @item.price = Item.find(params[:item_id]).price
    if @order_form.valid?
      pay_item
      @order_form.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def order_params
    # この時点では、order_idが不要。またrequire外の情報は参照するため、mergeとする。
    params.require(:order_form).permit(:postcode, :prefecture_id, :city, :block, :building, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,        # 商品の値段
      card: order_params[:token], # カードトークン
      currency: 'jpy'             # 通貨の種類（日本円）
    )
  end
end
