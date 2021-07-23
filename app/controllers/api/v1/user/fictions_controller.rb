class Api::V1::User::FictionsController < Api::AppController

before_action :set_fiction, only: [ :update, :destroy]
# skip_before_action :set_current_user_from_sites, only: [:index, :show]

    def index
        render json: Fiction.order(created_at: :desc), 
        include: [{ user: { only: :username } }, category: { only: :name }]
    end

    def create
        fiction = Fiction.new(params_for_create)
        fiction.user_id = current_user.id
        fiction.save
        render json: fiction.as_json
    end

    def show
        render json: Fiction.find(params[:id]), 
        include: [{ user: { only: :username } }, category: { only: :name }]
    end

    def update
        @fiction.update(params_for_update)
        render json: @fiction.as_json
    end

    def destroy
        @fiction.destroy
        render json: { success: true }
    end

private

    def set_fiction
        @fiction = current_user.fiction.find(params[:id])
    end

    def params_for_create
        params.require(:fiction).permit(:name, :description, :article, :user_id, :category_id)
    end

    def params_for_update
        params.require(:fiction).permit(:name, :description, :article, :user_id, :category_id)
    end
end