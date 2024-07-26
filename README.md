# Medical Records Management System ERD

## Overview
This ERD illustrates the relationships between various entities in the Medical Records Management System, focusing on patients, doctors, and appointments, as well as other related entities.

## Entities
- **Patients**: Information about patients.
- **Doctors**: Information about doctors.
- **Appointments**: Details of appointments between patients and doctors.
- **Medical Records**: Records of patient treatments and diagnoses.
- **Billing**: Details of billing information.
- **Rooms**: Room assignments and details.
- **Nurses**: Information about nursing staff.
- **Departments**: Department information.
- **Medications**: Information on medications prescribed.
- **Staff**: General staff information.

## Relationships
- Patients have appointments with doctors.
- Appointments are recorded in medical records.
- Billing information is linked to patients.
- Nurses and staff are associated with various departments and rooms.
- Medications are prescribed to patients and recorded in medical records.

## Diagram
Below is the ERD for the Medical Records Management System:

![Screenshot 2024-07-20 063842](https://github.com/user-attachments/assets/7ceffebc-2d20-4a82-95a7-5ab85a335059)


## Entity-Relationship Diagram for Medical Records Management System

The following Entity-Relationship (ER) diagram represents the database schema for a Medical Records Management System. This schema includes several interconnected tables that store various types of information critical to hospital operations, including details about departments, staff, doctors, patients, appointments, medical records, medications, and billing. Each table and its relationships are described below:

### Departments
- **departments_id** (Primary Key): Unique identifier for each department.
- **departments_name**: Name of the department.
- **location**: Location within the hospital.

### Staff
- **staff_id** (Primary Key): Unique identifier for each staff member.
- **first_name**: First name of the staff member.
- **last_name**: Last name of the staff member.
- **role**: Role of the staff member (e.g., nurse, technician).
- **email**: Email address of the staff member.
- **phone**: Contact phone number (optional).
- **department_id** (Foreign Key): References the department the staff member is associated with.

### Doctors
- **doctor_id** (Primary Key): Unique identifier for each doctor.
- **first_name**: First name of the doctor.
- **last_name**: Last name of the doctor.
- **specialization**: Medical specialization of the doctor.
- **email**: Email address of the doctor.
- **phone_number**: Contact phone number.
- **age**: Age of the doctor.
- **department_id** (Foreign Key): References the department the doctor is associated with.

### Patients
- **patient_id** (Primary Key): Unique identifier for each patient.
- **first_name**: First name of the patient.
- **last_name**: Last name of the patient.
- **date_of_birth**: Date of birth of the patient (optional).
- **address**: Address of the patient.
- **phone_number**: Contact phone number.
- **email**: Email address of the patient.
- **gender**: Gender of the patient.
- **room_id** (Foreign Key): References the room assigned to the patient.

### Rooms
- **room_number** (Primary Key): Unique identifier for each room.
- **type**: Type of the room (e.g., single, shared).
- **department_id** (Foreign Key): References the department the room belongs to.

### Appointments
- **appointment_id** (Primary Key): Unique identifier for each appointment.
- **appointment_date**: Date of the appointment.
- **status**: Status of the appointment (e.g., scheduled, completed).
- **patient_id** (Foreign Key): References the patient involved in the appointment.
- **doctor_id** (Foreign Key): References the doctor involved in the appointment.

### Medical Records
- **record_id** (Primary Key): Unique identifier for each medical record.
- **diagnosis**: Diagnosis information.
- **record_date**: Date the record was created.
- **treatment**: Treatment details.
- **doctor_id** (Foreign Key): References the doctor who created the record.
- **patient_id** (Foreign Key): References the patient the record belongs to.

### Prescriptions
- **prescriptions_id** (Primary Key): Unique identifier for each prescription.
- **dosage**: Dosage information.
- **start_date**: Start date of the prescription.
- **frequency**: Frequency of the medication.
- **end_date**: End date of the prescription.
- **doctor_id** (Foreign Key): References the doctor who prescribed the medication.

### Medications
- **med_id** (Primary Key): Unique identifier for each medication.
- **med_name**: Name of the medication.
- **description**: Description of the medication.
- **side_effects**: Possible side effects.
- **dosage**: Recommended dosage.

### Billing
- **bill_id** (Primary Key): Unique identifier for each bill.
- **amount**: Amount billed.
- **bill_date**: Date the bill was issued.
- **status**: Status of the bill (e.g., paid, unpaid).
- **patient_id** (Foreign Key): References the patient associated with the bill.

### Nurses
- **nurse_id** (Primary Key): Unique identifier for each nurse.
- **first_name**: First name of the nurse.
- **last_name**: Last name of the nurse.
- **phone**: Contact phone number.
- **email**: Email address of the nurse.
- **age**: Age of the nurse.

### Prescriptions_Medications
- **med_id** (Foreign Key): References the medication.
- **prescriptions_id** (Foreign Key): References the prescription.
- **med_date**: Date the medication was prescribed.

### Nurses_Rooms
- **nurse_id** (Foreign Key): References the nurse.
- **room_number** (Foreign Key): References the room.
- **hours**: Number of hours the nurse is assigned to the room.

### Nrs_ptnt_medic
- **patient_id** (Foreign Key): References the patient.
- **med_date**: Date of medication.
- **med_time**: Time of medication.
- **nurse_id** (Foreign Key): References the nurse administering the medication.
- **medication_id** (Foreign Key): References the medication.

## Diagram
![drawSQL-image-export-2024-07-23](https://github.com/user-attachments/assets/56893f9d-e9a4-4bf2-bbad-6eb283ddd4c1)



# Doctor Stored Procedures

This document provides an overview and usage guide for the stored procedures related to managing doctor records in a database.

## Table of Contents
- [CreateDoctor](#createdoctor)
- [DeleteDoctor](#deletedoctor)
- [UpdateDoctor](#updatedoctor)

## CreateDoctor

The `CreateDoctor` stored procedure is used to insert a new doctor's record into the `Doctor` table.

### Parameters

- `@f_name` (varchar(50)): The first name of the doctor.
- `@l_name` (varchar(50)): The last name of the doctor.
- `@spec` (varchar(100)): The specialization of the doctor.
- `@email` (varchar(250)): The email address of the doctor.
- `@age` (int): The age of the doctor.
- `@phone` (int): The phone number of the doctor.
- `@dept_id` (int): The department ID associated with the doctor.

### Usage

```sql
EXEC CreateDoctor @f_name = 'John', @l_name = 'Doe', @spec = 'Cardiology', @email = 'john.doe@example.com', @age = 45, @phone = 1234567890, @dept_id = 1;
```

### Constraints

- Age must be a positive integer. If `@age` is less than 0, the procedure will raise an error: `Age must be positive`.

---

## DeleteDoctor

The `DeleteDoctor` stored procedure is used to delete an existing doctor's record from the `Doctor` table.

### Parameters

- `@id` (int): The ID of the doctor to be deleted.

### Usage

```sql
EXEC DeleteDoctor @id = 1;
```

### Output Messages

- `Record deleted successfully.` if the record is found and deleted.
- `Record not found.` if the record with the specified `@id` does not exist.

---

## UpdateDoctor

The `UpdateDoctor` stored procedure is used to update an existing doctor's record in the `Doctor` table.

### Parameters

- `@id` (int): The ID of the doctor to be updated.
- `@f_name` (varchar(50)): The new first name of the doctor.
- `@l_name` (varchar(50)): The new last name of the doctor.
- `@spec` (varchar(100)): The new specialization of the doctor.
- `@email` (varchar(250)): The new email address of the doctor.
- `@age` (int): The new age of the doctor.
- `@phone` (int): The new phone number of the doctor.
- `@dept_id` (int): The new department ID associated with the doctor.

### Usage

```sql
EXEC UpdateDoctor @id = 1, @f_name = 'John', @l_name = 'Doe', @spec = 'Cardiology', @email = 'john.doe@example.com', @age = 46, @phone = 1234567890, @dept_id = 2;
```

### Constraints

- Age must be a positive integer. If `@age` is less than 0, the procedure will raise an error: `Age must be positive`.

### Output Messages

- `Record updated successfully.` if the record is found and updated.
- `Record not found.` if the record with the specified `@id` does not exist.

These stored procedures provide a robust way to manage doctor records in the database, ensuring data integrity and proper error handling.


### Code
![DoctorStored Prod](https://github.com/user-attachments/assets/1ce5e9c4-b30c-472f-9e52-a67a184b37f3)
