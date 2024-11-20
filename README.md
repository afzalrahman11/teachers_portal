# README

# Teacher Portal

## Overview

The **Teacher Portal** is a web application built using Ruby on Rails (RoR), HTML, and JavaScript. The portal allows teachers to:

- Log in securely using their credentials.
- View and manage a list of students, including editing and deleting student details.
- Add new students via a modal and update existing student details.

The system is designed to ensure that students are uniquely identified by their name and subject, and if a student with the same name and subject already exists, the marks are updated accordingly.

## Features

1. **Login Functionality**
   - Teachers can log in by providing their credentials.
   - Upon successful login, they are authenticated and redirected to the home screen.
   - If authentication fails, the system provides appropriate error messages.

2. **Teacher Portal Home & Student Listing**
   - After login, teachers are directed to the home screen, which serves as the student listing page.
   - Students' names, subjects, and marks are displayed in a table.
   - Teachers can edit student details inline, and the changes are reflected instantly.
   - Teachers can delete student records as needed.

3. **Add New Student**
   - Teachers can add a new student via a popup/modal.
   - The system checks if a student with the same name and subject already exists.
     - If a match is found, the marks are updated by adding the new marks.
     - If no match is found, a new student record is created.

## Technologies Used

- **Back-End**: Ruby on Rails (RoR)
  - Rails for the server-side logic, database interaction, and views.
- **Front-End**: HTML, CSS, JavaScript
  - Basic HTML and CSS for the UI layout.
  - Vanilla JavaScript for dynamic functionality, such as form submissions, modal popups, and inline editing.
- **Database**: PostgreSQL (default Rails database for development)

## Installation

### Prerequisites

Before you can run this project locally, you need to have the following installed:

- Ruby (version 3.0.0 or higher)
- Rails (version 7.x.x)
- SQLite3 (or PostgreSQL if you prefer)
- Node.js (for JavaScript assets)

### Steps to Run the Project Locally

1. **Clone the Repository**

   ```bash
   git clone https://github.com/afzalrahman11/teacher_portal.git
   cd teacher_portal


