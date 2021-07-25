class Api::V1::User::FictionsController < Api::AppController
    before_action :set_fiction, only: [ :update, :destroy]
    before_action :set_current_user_from_jwt, only: [:create, :update, :destroy]

    def index
        render json: Fiction.order(created_at: :desc), 
        include: [{ user: { only: :username } }, category: { only: :name }]
    end

    def show
        render json: Fiction.find(params[:id]), 
        include: [{ user: { only: :username } }, category: { only: :name }]
    end

    def create
        @fiction = Fiction.new(params_for_fiction)
        @fiction.user_id = @current_user.id
    if  @fiction.save
        render json: @fiction.as_json
    else
        render json: @fiction.errors, status: :unprocessable_entity
    end
    end

    def update
        if@fiction.update(params_for_fiction)
        render json: @fiction.as_json
        else
        render json: @fiction.errors, status: :unprocessable_entity
    end
    end

    def destroy
        if @fiction.destroy
            render status: :no_content
        else
            render json: { errors: @fiction.errors }, status: :unprocessable_entity
        end
    end

private

    def set_fiction
        @fiction =  Fiction.find(params[:id])
    end

    def params_for_fiction
        params.require(:fiction).permit(:name, :description, :article, :user_id, :category_id)
    end

end