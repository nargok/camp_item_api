module Api
  module V1
    class ItemsController < ApplicationController
      before_action :set_item, only: [:show, :update ,:destroy]

      def index
        items = Item.order(created_at: :desc)
        render json: { status: 'success', message: 'Loaded items', data: items }
      end

      def show
        render json: { status: 'success', message: 'Loaded the item', data: @item }
      end

      def create
        item = Item.new(item_params)
        if item.save
          render json: { status: 'success', data: item }
        else
          render json: { status: 'ERROR', data: item.errors }
        end
      end

      def update
        if @item.update(item_params)
          render json: { status: 'success', message: 'Updated the item', data: @item }
        else
          render json: { status: 'ERROR', message: 'Not updated', data: @item.errors }
        end
      end

      def destroy
        @item.destroy
        render json: { status: 'SECCESS', message: 'Deleted the item', data: @item }
      end

      private

      def set_item
        @item = Item.find(params[:id])
      end

      def item_params
        params.require(:item).permit(:name, :price)
      end

    end
  end
end
