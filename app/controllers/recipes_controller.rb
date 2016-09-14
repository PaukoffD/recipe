class RecipesController < ApplicationController

 # load_and_authorize_resource
  before_action :find_recipe, only: [:show, :edit, :destroy, :update]
  before_action :build_comment, only: :show

  def index
     @recipes = Recipe.order('created_at DESC').limit(4)
  end

  def new
    @recipe = Recipe.new
     respond_with(@purchase = Purchase.new)
  end

  def edit
  end

  def destroy
    @recipe.destroy
    redirect_to recipes_path
  end

  def create
    @recipe = Recipe.new(recipe_params)
    #@recipe.owner_id = current_user.id
    #upload=Cloudinary::Uploader.upload(purchase_params[:image]) unless purchase_params[:image].blank?
    #@purchase.image_file_name=upload['url'] unless purchase_params[:image].blank?
    #@recipe.image.save
    if @recipe.save
      #lo
      redirect_to recipes_path
    else
      lo
      render 'new'
    end 
  end

  def update
    if @recipe.update(recipe_params)
      redirect_to recipe_path(@recipe)
    else
      redirect_to edit_recipe_path(@recipe)
    end
  end

  def show
    @recipe       = Recipe.find(params[:id])
    
  end

  

  private

  def find_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:name, :description, :image, :short)
  end

  def build_comment
    @new_comment = Comment.build_from(@recipe, current_user, '')
  end
end
