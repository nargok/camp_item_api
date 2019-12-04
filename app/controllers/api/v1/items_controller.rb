module Api
  module V1
    class ItemsController < ApplicationController

      def index
        items = Item.order(created_at: :desc)
        render json: { status: 'success', message: 'Loaded items', data: items }
      end
    end
  end
end
