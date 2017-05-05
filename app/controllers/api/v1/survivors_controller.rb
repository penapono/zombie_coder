module Api
  module V1
    class SurvivorsController < ActionController::API
      before_action :load_survivor, only: %i[show update flag_infected]
      before_action :load_survivors, only: :index

      # Permitted Params
      PERMITTED_PARAMS = %i[
        name age gender latitude longitude
      ].freeze

      def index
        render json: @survivors
      end

      def show
        render json: @survivor
      end

      def create
        survivor = Survivor.new survivor_params
        if survivor.save
          render json: survivor, status: :success
        else
          render json: survivor.errors, status: :error
        end
      end

      def update
        if @survivor.update survivor_params
          render json: @survivor, status: :ok
        else
          render json: @survivor.errors, status: :error
        end
      end

      def flag_infected
        if @survivor.flag_infected
          render json: {
            status: :success,
            message: "Successfully marked as infected"
          }
        else
          render json: {
            status: :error,
            message: "Survivor couldn't be marked as infected"
          }
        end
      end

      private

      def survivor_params
        params.require(:survivor).permit(PERMITTED_PARAMS)
      end

      def load_survivor
        @survivor = Survivor.find(params[:id])
      end

      def load_survivors
        @survivors = Survivor.all
      end
    end
  end
end
