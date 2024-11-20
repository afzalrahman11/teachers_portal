class Student < ApplicationRecord
  validates :name, :subject, :marks, presence: true
  validates :marks, numericality: { greater_than_or_equal_to: 0 }

  # Custom method to handle the new student creation or updating the marks if student exists
  def self.create_or_update_student(student_params)
    student = Student.find_by(name: student_params[:name], subject: student_params[:subject])

    if student
      # Update the marks by adding the new marks to the existing marks
      student.marks += student_params[:marks].to_i
      if student.save
        student
      else
        nil
      end
    else
      # If no student found, create a new record
      student = Student.new(student_params)
      student.save ? student : nil
    end
  end
end
