class ExpensesController < ApplicationController
  before_action :set_expense, only: %i[edit update destroy]
  before_action :set_user, only: %i[index edit create update destroy]
  before_action :set_group, only: %i[index new edit create update destroy]

  def index
    @expenses = @group.expenses.order(created_at: :desc)
  end

  def new
    @expense = Expense.new
  end

  def create
    @expense = Expense.new(author: @author, **expense_params)
    if @expense.save
      @group_expense = GroupExpense.create(group: @group, expense: @expense)
      redirect_to group_expenses_url(@group), notice: 'Expense has been successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def destroy
    @expense.destroy
    redirect_to group_expenses_url(@group), notice: 'Expense has been successfully destroyed.'
  end

  def update
    if @expense.update(expense_params)
      redirect_to group_expenses_url, notice: 'Expense has been successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_group
    @group = set_user.groups.find(params[:group_id])
  end

  def set_expense
    @expense = set_user.expenses.find(params[:id])
  end

  def set_user
    @author = current_user
  end

  def expense_params
    params.require(:expense).permit(:name, :amount)
  end
end
