class CardsController < ApplicationController
  require "payjp"
  before_action :set_card, only: [:index, :new, :delete, :show]

  def index
    # @card = Card.find_by(user_id: current_user.id)
  end

  def new
    # card = Card.where(user_id: current_user.id)
    redirect_to card_path(@card) if @card.present?
  end

  def pay #payjpとCardのデータベース作成を実施します。
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    if params['payjp-token'].blank?
      redirect_to new_card_url 
    else
      customer = Payjp::Customer.create(
      description: '登録テスト', #なくてもOK
      email: current_user.email, #なくてもOK
      card: params['payjp-token'],
      metadata: {user_id: current_user.id}
      ) #念の為metadataにuser_idを入れましたがなくてもOK
      @card = Card.new(user_id: current_user.id, customer_id: customer.id, payjp_id: customer.default_card)
      if @card.save
        redirect_to card_path(@card.id)
      else
        redirect_to pay_cards_path
      end
    end
  end

  def delete #PayjpとCardデータベースを削除します
    # card = Card.where(user_id: current_user.id).first
    if @card.blank?
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(@card.customer_id)
      customer.delete
      @card.delete
    end
      redirect_to cards_path
  end

  def show #Cardのデータpayjpに送り情報を取り出します
    # card = Card.where(user_id: current_user.id).first
    if @card.blank?
      redirect_to new_card_url 
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(@card.customer_id)
      # customer = Payjp::Customer.retrieve("cus_2d9a92504a0560103b7d9015be1a")
      @default_card_information = customer.cards.retrieve(@card.payjp_id)
      # @default_card_information = customer.cards.retrieve("car_0fffe95b34ec4c4cb204342647d1")
    end
  end

  private
  def set_card
    @card = Card.find_by(user_id: current_user.id)
  end
end