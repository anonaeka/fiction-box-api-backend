class Api::V1::User::CategoriesController < Api::V1::User::HeaderController
    before_action :set_category, except: [:index, :create]
    before_action :set_current_user_from_header, only: [:create, :update, :destroy]

    def index
        render json: Category.order(created_at: :desc)
    end

    def show
        render json: @category, include: [:fictions]
    end

    def create
        category = Category.new(category_params)
        if category.save
            render json: category, status: :created
        else
            render json: category.errors, status: :unprocessable_entity
        end
    end

    def update
        if @category.update(category_params)
            render json: @category
        else
            render json: @category.errors, status: :unprocessable_entity
        end
    end

    def destroy
        render status: :not_implemented
    end

    private

    def set_category
        @category = Category.find(params[:id])
    end

    def category_params
        params.require(:category).permit(:name)
    end
end
