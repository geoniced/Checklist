class ItemsController < ApplicationController
  before_action :find_item, only: [:show, :edit, :update, :destroy]
	
  def index
    if user_signed_in?
      @items = Item.where(:user_id => current_user.id).order("created_at DESC")
    end
	end

  def show
    
  end

  def new
    @item = current_user.items.build
  end

  def create
    @item = current_user.items.build(item_params)
    if @item.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render 'edit'
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end
  
  # TODO: move first line (find) into the before_action method
  def complete
    @item = Item.find(params[:id])
    if @item.try(:completed_at).nil?
      @item.update_attribute(:completed_at, Time.now)
    else
      @item.update_attribute(:completed_at, nil)
    end
    redirect_to root_path
  end

  private

    def item_params
      params.require(:item).permit(:title, :description)
    end

    def find_item
      @item = Item.find(params[:id])
    end
end
