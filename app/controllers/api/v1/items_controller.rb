class Api::V1::ItemsController < ApplicationController
  def index
    items = Item.all
    render json: serialize_item(items)
  end

  def show
    item = Item.find(params[:id])
    render json: serialize_item(item)
  end

  private

  def serialize_item(records)
    ItemSerializer.new(records).serialized_json
  end
end
