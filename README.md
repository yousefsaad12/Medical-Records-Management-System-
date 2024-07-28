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

The following Entity-Relationship (ER) diagram represents the database schema for a Medical Records Management System. This schema includes several interconnected tables that store various types of information critical to hospital operations, including details about departments, staff, doctors, patients, appointments, medical records, medications, and billing. Each table and its relationships are described in Diagram below:

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




# Doctor Views 

This repository contains SQL scripts to create views that provide various insights and details about doctors, their appointments, financial impacts, and prescription histories.

## Views Overview

### 1. `GetAllDoctor`
Provides a comprehensive list of all doctors.

### 2. `DoctorsAppointments`
Provides doctors with a comprehensive list of their appointments, including patient details and the status of each appointment.

### 3. `Doctors_Comprehensive_Financial_Impact`
Provides a comprehensive view of the financial impact of a doctor's services, including billing details and revenue generated per department.

### 4. `Doctors_Prescription_History`
Allows doctors to review their prescription history, including details of the medications prescribed to patients.

## Usage

1. **GetAllDoctor**: Run this view to get a list of all doctors in the database.
2. **DoctorsAppointments**: Run this view to get detailed information about doctors' appointments including patient details.
3. **Doctors_Comprehensive_Financial_Impact**: Run this view to get insights into the financial impact of each doctor, grouped by department.
4. **Doctors_Prescription_History**: Run this view to track the prescription history of doctors.

## Notes

- Ensure all the necessary tables (`Doctor`, `Appointment`, `Patient`, `Department`, `Billing`, `Prescription`, `Prescription_Medication`, and `Medication`) exist in your database schema before creating these views.
- Modify the table names and columns as per your database schema if they differ.

## Code
![Doctor Views](https://github.com/user-attachments/assets/7ac04be7-0728-46c0-a108-76bf04fb1ae6)


# Appointment Stored Procedures

This repository contains SQL scripts to create stored procedures for managing appointments, including creating, updating, and deleting appointments.

## Procedures Overview

### 1. `CreateAppointment`
Creates a new appointment if the doctor and patient IDs exist in the `Doctor` and `Patient` tables respectively.

### 2. `UpdateAppointment`
Updates an existing appointment if the appointment ID exists in the `Appointment` table.

### 3. `DeleteAppointment`
Deletes an existing appointment if the appointment ID exists in the `Appointment` table.

## Usage

1. **CreateAppointment**: 
    - Parameters:
        - `@app_date` (date): The date of the appointment.
        - `@status` (varchar(50)): The status of the appointment.
        - `@pt_id` (int): The patient ID.
        - `@dr_id` (int): The doctor ID.
    - This procedure checks if the provided doctor and patient IDs exist. If they do, it inserts a new record into the `Appointment` table.

2. **UpdateAppointment**:
    - Parameters:
        - `@app_id` (int): The appointment ID.
        - `@app_date` (date): The new date for the appointment.
        - `@status` (varchar(50)): The new status for the appointment.
    - This procedure checks if the provided appointment ID exists. If it does, it updates the appointment date and status.

3. **DeleteAppointment**:
    - Parameters:
        - `@app_id` (int): The appointment ID.
    - This procedure checks if the provided appointment ID exists. If it does, it deletes the record from the `Appointment` table.

## Notes

- Ensure all the necessary tables (`Doctor`, `Patient`, `Appointment`) exist in your database schema before creating these procedures.
- Modify the table names and columns as per your database schema if they differ.

## Code
![Appointment Porc](https://github.com/user-attachments/assets/f5bcdd22-2016-4ef6-91d7-9cf39c2c6fc2)

