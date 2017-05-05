module Api
  module V1
    class SurvivorsController < ActionController::API
      # Permitted Params
      PERMITTED_PARAMS = %i[
        name age gender latitude longitude
      ].freeze

      def index
        survivors = Survivor.all
        render json: survivors
      end

      def show
        survivor = Survivor.find(params[:id])
        render json: survivor
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
        survivor = Survivor.find(params[:id])
        if survivor.update survivor_params
          render json: survivor, status: :ok
        else
          render json: survivor.errors, status: :error
        end
      end

      private

      def survivor_params
        params.require(:survivor).permit(PERMITTED_PARAMS)
      end
    end
  end
end
