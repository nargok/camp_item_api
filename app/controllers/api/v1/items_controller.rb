module Api
  module V1
    class ItemsController < ApplicationController
      before_action :set_item, only: [:show]

      def index
        items = Item.order(created_at: :desc)
        render json: { status: 'success', message: 'Loaded items', data: items }
      end

      def show
        render json: { status: 'success', message: 'Loaded items', data: @item }
      end

      private

      def  set_item
        @item = Item.find(params[:id])
      end

    end
  end
end
