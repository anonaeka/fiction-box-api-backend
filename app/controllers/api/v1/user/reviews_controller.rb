class Api::V1::User::ReviewsController < Api::V1::User::HeaderController
    before_action :set_review, only: [:show, :update, :destroy]
    before_action :set_current_user_from_header, only: [:create, :update, :destroy]
    before_action :control_reviews, only: [:update, :destroy]

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
        @review.user_id = @current_user.id
    if  @review.save
        render json: @review.as_json
    else
        render json: @review.errors, status: :unprocessable_entity
    end
    end

    def update
        if @reviews.update(review_params)
            render json: @reviews
        else
            render json: { errors: @reviews.errors }, status: :unprocessable_entity
        end
    end
    
    def destroy
        if @reviews.destroy
            render status: :no_content
        else
            render json: { errors: @reviews.errors }, status: :unprocessable_entity
        end
    end

    private

    def set_review
        @review = Review.find(params[:id])
    end

    def control_reviews
        @reviews = @current_user.reviews.find(params[:id])
    end

    def review_params
        params.require(:review).permit(:user_id, :fiction_id, :title, :description , :score)
    end


end