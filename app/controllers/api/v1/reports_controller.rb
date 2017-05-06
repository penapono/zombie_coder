module Api
  module V1
    class ReportsController < ActionController::API
      def infected
        render json: {
          status: :success,
          rate: Survivor.total_infected_str
        }
      end

      def non_infected
        render json: {
          status: :success,
          rate: Survivor.total_non_infected_str
        }
      end

      def average_resource
        render json: {
          status: :success,
          rate: Item.average_resource
        }
      end

      def lost_points
        render json: {
          status: :success,
          rate: Item.lost_points
        }
      end
    end
  end
end
