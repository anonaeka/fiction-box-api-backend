class Api::V1::User::ReviewsController < Api::AppController
    before_action :set_review, only: [:show, :update, :destroy]
    before_action :set_current_user_from_jwt, only: [:create, :update, :destroy]

    def index
        # render json: Review.order(created_at: :desc),
        # include: [{ user: { only: :username } }, fiction: { only: :name }]
        render status: :not_implemented
    end

    def show
        render json: @review,
        include: [{ user: { only: :username } }, fiction: { only: :name }]
    end

    def create
        @review = Review.new(review_params)
        if @review.save
            render json: @review, status: :created
        else
            render json: { errors: @review.errors }, status: :unprocessable_entity
        end
    end

    def update
        if @review.update(review_params)
            render json: @review
        else
            render json: { errors: @review.errors }, status: :unprocessable_entity
        end
    end
    
    def destroy
        if @review.destroy
            render status: :no_content
        else
            render json: { errors: @review.errors }, status: :unprocessable_entity
        end
    end

    private

    def set_review
        @review = Review.find(params[:id])
    end

    def review_params
        params.require(:review).permit(:user_id, :fiction_id, :title, :description , :score)
    end

end