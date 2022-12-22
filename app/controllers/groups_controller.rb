class GroupsController < ApplicationController
  before_action :set_users, only: %i[index edit create update destroy]
  before_action :set_groups, only: %i[edit update destroy]

  def index
    @groups = @author.groups
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(author: @author, **groups_params)

    if @group.save
      flash[:notice] = 'Group has been successfully created.'
      redirect_to groups_url
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    return unless @group.destroy

    flash[:notice] = 'Group has been successfully destroyed.'
    redirect_to groups_url
  end

  def edit; end

  def update
    if @group.update(groups_params)
      flash[:notice] = 'Group has been successfully updated.'
      redirect_to groups_url
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_groups
    @group = set_users.groups.find(params[:id])
  end

  def set_users
    @author = current_user
  end

  def groups_params
    params.require(:group).permit(:name, :icon)
  end
end
