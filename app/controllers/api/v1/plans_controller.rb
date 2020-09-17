module Api
  module V1
    class PlansController < ApplicationController
      before_action :set_plan, only: [:show, :update ,:destroy]

      def index
        plans = Plan.order(created_at: :desc)
        render json: { status: 'success', message: 'Loaded plans', data: plans }
      end

      def show
        render json: { status: 'success', message: 'Loaded the plan', data: { title: @plan.title, place: @plan.place, memo: @plan.memo, items: @plan.items } }
      end

      def create
        @plan = Plan.new(plan_params)
        if @plan.save
          create_plan_items
          render json: { status: 'success', data: @plan }
        else
          render json: { status: 'ERROR', data: @plan.errors }
        end
      end

      def update
        if @plan.update(plan_params)
          @plan.items.destroy_all
          create_plan_items
          render json: { status: 'success', message: 'Updated the item', data: @plan }
        else
          render json: { status: 'ERROR', message: 'Not updated', data: @plan.errors }
        end
      end

      def destroy
        if @plan.destroy
          @plan.items.destroy_all
          render json: { status: 'SECCESS', message: 'Deleted the item', data: @item }
        end
      end

      private

      def set_plan
        @plan = Plan.find(params[:id])
      end

      def plan_params
        params.require(:plan).permit(:title, :place, :memo)
      end

      def create_plan_items
        params[:item_ids].each do |p|
          # TODO N + 1を解消する
          item = Item.find(p)
          @plan.items << item
        end if params[:item_ids].length > 0
      end

    end
  end
end
