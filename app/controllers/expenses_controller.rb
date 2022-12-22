class ExpensesController < ApplicationController
  before_action :set_expenses, only: %i[edit update destroy]
  before_action :set_users, only: %i[index edit create update destroy]
  before_action :set_groups, only: %i[index new edit create update destroy]

  def index
    @expenses = @group.expenses.order(created_at: 'desc')
  end

  def new
    @expense = Expense.new
  end

  def create
    @expense = Expense.new(author: @author, **expenses_params)
    if @expense.save
      @group_expense = GroupExpense.create(group: @group, expense: @expense)
      flash[:notice] = 'Expense has been successfully created.'
      redirect_to group_expenses_url(@group)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def destroy
    return unless @expense.destroy

    flash[:notice] = 'Expense has been successfully destroyed.'
    redirect_to group_expenses_url(@group)
  end

  def update
    if @expense.update(expenses_params)
      flash[:notice] = 'Expense has been successfully updated.'
      redirect_to group_expenses_url
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_groups
    @group = set_users.groups.find(params[:group_id])
  end

  def set_expenses
    @expense = set_users.expenses.find(params[:id])
  end

  def set_users
    @author = current_user
  end

  def expenses_params
    params.require(:expense).permit(:name, :amount)
  end
end
