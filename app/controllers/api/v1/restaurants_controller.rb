module Api
  module V1
    class RestaurantsController < ApplicationController
      def index
        restaurants = Restaurant.all
        render json: RestaurantSerializer.new(restaurants, options).serialized_json
      end
      
      def show
        restaurant = Restaurant.find_by(slug: params[:slug])
        render json: RestaurantSerializer.new(restaurant, options).serialized_json
      end

      def create
        restaurant = Restaurant.new(restaurant_params)
        if restaurant.save
          render json: RestaurantSerializer.new(restaurant).serialized_json
        else
          render json: {error: restaurant.errors.messages}, status: 422
        end
      end

      def update
        restaurant = Restaurant.find_by(slug: params[:slug])
        if restaurant.update(restaurant_params)
          render json: RestaurantSerializer.new(restaurant, options).serialized_json
        else
          render json: {error: restaurant.errors.messages}, status: 422
        end
      end

      def destroy
        restaurant = Restaurant.find_by(slug: params[:slug])
        if restaurant.destroy
          head :no_content
        else
          render json: {error: restaurant.errors.messages}, status: 422
        end
      end

      private

      def restaurant_params
      params.require(:restaurant).permit(:name, :location, :url_link, :image_url)
      end

      def options
        @options ||= {include: %i[reviews]}
      end


    end
  end
end
