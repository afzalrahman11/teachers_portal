class StudentsController < ApplicationController
  before_action :authenticate_teacher!
  before_action :get_student, only: [ :show, :edit, :update, :destroy, :perform_simple_job, :perform_sidekiq_job ]

  def index
    @students = Student.all
  end

  def show; end

  def new
    @student = Student.new
  end

  def create
    # Use the custom create_or_update_student method
    @student = Student.create_or_update_student(student_params)

    if @student
      flash[:notice] = 'Student successfully created or updated.'
      redirect_to students_path
    else
      flash[:alert] = 'There was an error processing the student details.'
      render :new
    end
  end

  def edit; end

  def update
    @student = Student.find(params[:id])

    if @student.update(student_params)
      render json: @student, status: :ok
    else
      render json: { errors: @student.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @student.destroy
    flash[:notice] = 'Student successfully deleted.'
    redirect_to students_path
  end

  def perform_simple_job
    # SimpleJob.perform_later(@student, 11, "Afzal Rahman") --> basic job without time mentioned
    SimpleJob.set(wait: 30.seconds).perform_later(@student, 11, 'Afzal Rahman')
  end

  def perform_sidekiq_job
    SimpleSidekiqJob.perform_async(@student.name, 11, 'Afzal Rahman')
    SimpleSidekiqJob.perform_async(@student.name, 12, 'Afzal Rahman12')
    SimpleSidekiqJob.perform_async(@student.name, 13, 'Afzal Rahman13')
    SimpleSidekiqJob.perform_async(@student.name, 14, 'Afzal Rahman14')
    SimpleSidekiqJob.perform_async(@student.name, 15, 'Afzal Rahman15')
    SimpleSidekiqJob.perform_async(@student.name, 16, 'Afzal Rahman16')
    SimpleSidekiqJob.perform_async(@student.name, 17, 'Afzal Rahman17')
    SimpleSidekiqJob.perform_async(@student.name, 18, 'Afzal Rahman18')
    SimpleSidekiqJob.perform_async(@student.name, 19, 'Afzal Rahman19')
  end

  private

  def get_student
    @student = Student.find(params[:id])
  end

  def student_params
    params.require(:student).permit(:name, :subject, :marks)
  end
end
