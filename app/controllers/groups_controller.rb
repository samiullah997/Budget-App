class GroupsController < ApplicationController
  before_action :set_user, only: %i[index edit create update destroy]
  before_action :set_group, only: %i[edit update destroy]

  def index
    @groups = @author.groups
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(author: @author, **group_params)

    if @group.save
      redirect_to groups_url, notice: 'Group has been successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @group.destroy
    redirect_to groups_url, notice: 'Group has been successfully destroyed.'
  end

  def edit; end

  def update
    if @group.update(group_params)
      redirect_to groups_url, notice: 'Group has been successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_group
    @group = set_user.groups.find(params[:id])
  end

  def set_user
    @author = current_user
  end

  def group_params
    params.require(:group).permit(:name, :icon)
  end
end
