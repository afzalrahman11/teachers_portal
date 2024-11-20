class StudentsController < ApplicationController
  before_action :authenticate_teacher!

  def index
    @students = Student.all
  end

  def new
    @student = Student.new
  end

  def create
    # Use the custom create_or_update_student method
    @student = Student.create_or_update_student(student_params)

    if @student
      flash[:notice] = "Student successfully created or updated."
      redirect_to students_path
    else
      flash[:alert] = "There was an error processing the student details."
      render :new
    end
  end

  def edit
    @student = Student.find(params[:id])
  end

  def update
    @student = Student.find(params[:id])

    if @student.update(student_params)
      render json: @student, status: :ok
    else
      render json: { errors: @student.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @student = Student.find(params[:id])

    @student.destroy
    flash[:notice] = "Student successfully deleted."
    redirect_to students_path
  end

  private

  def student_params
    params.require(:student).permit(:name, :subject, :marks)
  end
end
