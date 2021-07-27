class Api::V1::User::FictionsController < Api::V1::User::HeaderController
    before_action :set_fiction, only: [ :show, :update, :destroy]
    before_action :set_current_user_from_header, only: [:manage_fiction, :create, :update, :destroy]
    before_action :control_fiction, only: [:update, :destroy]
    

    def index
        render json: Fiction.order(created_at: :desc), 
        include: [{ user: { only: :username } }, category: { only: :name }]
    end

    def manage_fiction
        @fictionuser = Fiction.where(user_id: @current_user)
        render json: @fictionuser.as_json, 
        include: [{ user: { only: :username } }, category: { only: :name }]
    end

    def show
        render json: @fiction, 
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
        if @fictions.update(params_for_fiction)
        render json: @fictions.as_json
        else
        render json: @fictions.errors, status: :unprocessable_entity
    end
    end

    def destroy
        if @fictions.destroy
            render status: :no_content
        else
            render json: { errors: @fictions.errors }, status: :unprocessable_entity
        end
    end

private

    def set_fiction
        @fiction =  Fiction.find(params[:id])
    end

    def control_fiction
        @fictions = @current_user.fictions.find(params[:id])
    end

    def params_for_fiction
        params.require(:fiction).permit(:name, :description, :article, :user_id, :category_id, :image_url)
    end

end