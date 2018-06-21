class CardsController < ApplicationController
  def index
    @cards = Card.all.order('cost, name')
  end

  def show
    @card = Card.find(params[:id])
    respond_to do |format|
      format.html
      format.json
    end
  end

  def search
    @cards = Card.where('name LIKE(?)',"%#{params[:keyword]}%")
    if params[:sub_type_keyword].present?
      @cards = @cards.where('sub_type LIKE(?)',"%#{params[:sub_type_keyword]}%")
    end
    if params[:aspects].present? && params[:aspects].exclude?("ALL")
      @cards = @cards.where(aspect: params[:aspects])
    end
    if params[:types].present? && params[:types].exclude?("ALL")
      @cards = @cards.where(type: params[:types])
    end
    if params[:costs].present? && params[:costs].exclude?("ALL")
      @cards = @cards.where(cost: params[:costs])
    end
    if params[:rarites].present? && params[:rarites].exclude?("ALL")
      @cards = @cards.where(rarity: params[:rarites])
    end
    @cards = @cards.order('cost, name')
    respond_to do |format|
      format.html
      format.json
    end
  end
end
