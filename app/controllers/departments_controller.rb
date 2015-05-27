class DepartmentsController < ApplicationController
  before_action :find_department, only: [:destroy, :edit, :update]

  def create
    @department = Department.create department_parameters
    if @department
      flash[:message] = "Department #{@department.name} successfully created."
      redirect_to root_path
    else show_errors
    end
  end

  def destroy
    @department.destroy
    flash[:message] = "Department #{@department.name} and any positions deleted."
    redirect_to root_path
  end

  def edit
  end

  def new
  end

  def update
    if @department.update department_parameters
      flash[:message] = "#{@department.name} has been updated."
      redirect_to root_path
    else show_errors
    end
  end

  private

  def find_department
    params.require :id
    @department = Department.find params[:id]
  end

  def department_parameters
    params.require(:department).permit :name
  end

  def show_errors
    flash[:errors] = @department.errors.full_messages
    redirect_to :back
  end

end
