import { Controller } from "@hotwired/stimulus";

// Define your controller as a Stimulus class
export default class extends Controller {
  connect() {
    // This runs when the controller is initialized
    console.log("StudentsController connected");
    
    // Enable edit mode on button click
    document.querySelectorAll(".btn-edit").forEach((button) => {
      button.addEventListener("click", (event) => {
        const studentId = event.target.dataset.studentId;
        this.toggleEditMode(studentId, true);
      });
    });

    // Save updated data to the server
    document.querySelectorAll(".btn-save").forEach((button) => {
      button.addEventListener("click", async (event) => {
        const studentId = event.target.dataset.studentId;
        const nameField = document.querySelector(`.edit-name[data-student-id="${studentId}"]`);
        const subjectField = document.querySelector(`.edit-subject[data-student-id="${studentId}"]`);
        const marksField = document.querySelector(`.edit-marks[data-student-id="${studentId}"]`);
        
        const updatedData = {
          name: nameField.value,
          subject: subjectField.value,
          marks: marksField.value,
        };

        try {
          const response = await fetch(`/students/${studentId}`, {
            method: "PATCH",
            headers: {
              "Content-Type": "application/json",
              "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content,
            },
            body: JSON.stringify({ student: updatedData }),
          });

          if (response.ok) {
            const updatedStudent = await response.json();
            // Update the display
            document.querySelector(`.student-name[data-student-id="${studentId}"]`).textContent = updatedStudent.name;
            document.querySelector(`.student-subject[data-student-id="${studentId}"]`).textContent = updatedStudent.subject;
            document.querySelector(`.student-marks[data-student-id="${studentId}"]`).textContent = updatedStudent.marks;
            this.toggleEditMode(studentId, false);
          } else {
            alert("Error updating student details.");
          }
        } catch (error) {
          console.error("Error:", error);
          alert("Failed to update student.");
        }
      });
    });

    // Cancel editing
    document.querySelectorAll(".btn-cancel").forEach((button) => {
      button.addEventListener("click", (event) => {
        const studentId = event.target.dataset.studentId;
        this.toggleEditMode(studentId, false);
      });
    });
  }

  // Helper function to toggle between edit mode and display mode
  toggleEditMode(studentId, editMode) {
    const spanFields = document.querySelectorAll(`span[data-student-id="${studentId}"]`);
    const inputFields = document.querySelectorAll(`input[data-student-id="${studentId}"]`);
    const editButton = document.querySelector(`.btn-edit[data-student-id="${studentId}"]`);
    const saveButton = document.querySelector(`.btn-save[data-student-id="${studentId}"]`);
    const cancelButton = document.querySelector(`.btn-cancel[data-student-id="${studentId}"]`);

    // Toggle the display of elements based on the edit mode
    spanFields.forEach((field) => (field.style.display = editMode ? "none" : "inline"));
    inputFields.forEach((field) => (field.style.display = editMode ? "inline" : "none"));
    editButton.style.display = editMode ? "none" : "inline";
    saveButton.style.display = editMode ? "inline" : "none";
    cancelButton.style.display = editMode ? "inline" : "none";
  }
}
