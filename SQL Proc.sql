/* //////////////// Doctor Proc //////////////// */

create proc CreateDoctor
@f_name varchar(50),
@l_name varchar(50),
@spec varchar(100),
@email varchar(250),
@age int,
@phone int,
@dept_id int
as
begin
	if(@age < 0)
	begin
		raiserror('Age must be positive.', 16, 1)
		return;
	end

	insert into Doctor(first_name, last_name, specialization, email, age, phone_number, department_id)
	values(@f_name, @l_name, @spec, @email, @age, @phone, @dept_id)
end;
GO

create proc DeleteDoctor
@id int
as 
begin
		If EXISTS(select doctor_id from Doctor where doctor_id = @id)
		begin
			delete from Doctor where doctor_id = @id

			select 'Record deleted successfully.' as Message
		end

		else select 'Record not found.' as Message
end;
GO

create proc UpdateDoctor
@id int,
@f_name varchar(50),
@l_name varchar(50),
@spec varchar(100),
@email varchar(250),
@age int,
@phone int,
@dept_id int
as
begin
	if(@age < 0)
	begin
		raiserror('Age must be positive.', 16, 1)
		return;
	end

	If EXISTS(select doctor_id from Doctor where doctor_id = @id)
	begin
		update Doctor
		set
			first_name = @f_name, 
			last_name = @l_name, 
			specialization = @spec, 
			email = @email, 
			age = @age, 
			phone_number = @phone, 
			department_id = @dept_id
		where doctor_id = @id

		select 'Record Updated successfully.' as Message
	end

	else select 'Record not found.' as Message
end
GO

/* //////////////// Medication Proc //////////////// */

create proc CreateMedication
@m_name varchar(250),
@des varchar(400),
@se varchar(200),
@do varchar(100)
as
begin
	insert into Medication(med_name, description, side_effects, dosage )
	values(@m_name, @des, @se, @do)
end;
GO

create proc DeleteMedication
@id int
as 
begin
		If EXISTS(select med_id from Medication where med_id = @id)
		begin
			delete from Medication where med_id = @id

			select 'Medication deleted successfully.' as Message
		end

		else select 'Medication not found.' as Message
end;
GO

create proc UpdateMedication
@id int,
@m_name varchar(250),
@des varchar(400),
@se varchar(200),
@do varchar(100)
as
begin

	If EXISTS(select med_id from Medication where med_id = @id)
	begin
		update Medication
		set
			med_name = @m_name, 
			description = @des,
			side_effects = @se,
			dosage = @do
		where med_id = @id

		select 'Medication Updated successfully.' as Message
	end

	else select 'Medication not found.' as Message
end
GO

/* //////////////// Department Proc //////////////// */

create proc CreateDepartment
@d_name varchar(50),
@loc varchar(200)
as
begin
	insert into Department(department_name, location)
	values(@d_name, @loc)
end;
GO

create proc DeleteDepartment
@id int
as 
begin
		If EXISTS(select department_id from Department where department_id = @id)
		begin
			delete from Department where department_id = @id

			select 'Department deleted successfully.' as Message
		end

		else select 'Department not found.' as Message
end;
GO

create proc UpdateDepartment
@id int,
@d_name varchar(50),
@loc varchar(200)
as
begin

	If EXISTS(select department_id from Department where department_id = @id)
	begin
		update Department
		set
			department_name = @d_name, 
			location = @loc
		where department_id = @id

		select 'Department Updated successfully.' as Message
	end

	else select 'Department not found.' as Message
end
GO

/* //////////////// Billing Proc //////////////// */

create proc CreateBilling
@amount decimal(19, 4),
@bill_date date,
@status varchar(50),
@patient_id int
as
begin
	If EXISTS(select patient_id from Patient where patient_id = @patient_id)
	begin
		insert into Billing(amount, bill_date, status, patient_id)
		values(@amount, @bill_date, @status, @patient_id)

		select 'Bill Created successfully.' as Message
	end

	else select 'Patient Id Not Found.' as Message

end;
GO

create proc DeleteBilling
@id int
as 
begin
		If EXISTS(select bill_id from Billing where bill_id = @id)
		begin
			delete from Billing where bill_id = @id

			select 'Bill Record deleted successfully.' as Message
		end

		else select 'Bill Record not found.' as Message
end;
GO

create proc UpdateBilling
@id int,
@amount decimal(19, 4),
@status varchar(50)
as
begin

	If EXISTS(select bill_id from Billing where bill_id = @id)
	begin
		update Billing
		set
			amount = @amount, 
			status = @status
		where bill_id = @id

		select 'Bill Record Updated successfully.' as Message
	end

	else select 'Bill Record not found.' as Message
end
GO

/* //////////////// Appointment Proc //////////////// */
create proc CreateAppointment
@app_date date,
@status varchar(50),
@pt_id int,
@dr_id int
as
begin
	If EXISTS(select doctor_id from Doctor where doctor_id = @dr_id)
	AND EXISTS (select patient_id from Patient where patient_id = @pt_id)
	begin
		insert into Appointment (appointment_date, status, patient_id, doctor_id)
		values(@app_date, @status, @pt_id, @dr_id)
	end
	
	else select 'Patient Id or Doctor Id Does not found' as Message
end
GO

create proc UpdateAppointment 
@app_id int,
@app_date date,
@status varchar(50)
as
begin
	If EXISTS(select appointment_id  from Appointment where appointment_id = @app_id)
	begin
		Update Appointment 
		set
		appointment_date = @app_date, 
		status = @status 
		where appointment_id = @app_id 

		select 'Appointment Updated successfully' as Message
	end
	
	else select 'Appointment Does not found' as Message
end

GO

create proc DeleteAppointment
@app_id int
as
begin

	If EXISTS(select appointment_id  from Appointment where appointment_id = @app_id)
	begin
		delete from Appointment where appointment_id = @app_id
		select 'Appointment Deleted successfully' as Message
	end
	else select 'Appointment Does not found' as Message
end 

GO

/* //////////////// NURSE Proc //////////////// */
create proc CreateNurse
@f_name varchar(50),
@l_name varchar(50),
@phone int,
@email varchar(250),
@age int
as
begin 
	if(@age > 21)
	begin
		insert into Nurse(first_name, last_name, phone, email, age)
		values(@f_name, @l_name, @phone, @email, @age)
	end

	else select 'Age must be above 21' as Message
end

GO

CREATE PROCEDURE UpdateNurse
    @id INT,
    @f_name VARCHAR(50) = NULL,
    @l_name VARCHAR(50) = NULL,
    @phone INT = NULL,
    @age INT = NULL,
    @Email VARCHAR(250) = NULL
AS
BEGIN
    IF EXISTS(SELECT 1 FROM Nurse WHERE nurse_id = @id)
    BEGIN
        DECLARE @sql NVARCHAR(MAX)
        SET @sql = 'UPDATE Nurse SET '
        
        IF @f_name IS NOT NULL
        BEGIN
            SET @sql = @sql + 'first_name = @f_name, '
        END
        
        IF @l_name IS NOT NULL
        BEGIN
            SET @sql = @sql + 'last_name = @l_name, '
        END
        
        IF @phone IS NOT NULL
        BEGIN
            SET @sql = @sql + 'phone = @phone, '
        END
        
        IF @Email IS NOT NULL
        BEGIN
            SET @sql = @sql + 'email = @Email, '
        END
        
        IF @age IS NOT NULL
        BEGIN
            IF @age > 21
            BEGIN
                SET @sql = @sql + 'age = @age, '
            END
            ELSE
            BEGIN
                SELECT 'Age must be above 21' AS Message
                RETURN
            END
        END

        -- Remove the trailing comma and space
        SET @sql = LEFT(@sql, LEN(@sql) - 2)
        
        SET @sql = @sql + ' WHERE nurse_id = @id'
        
        -- Execute the dynamic SQL
        EXEC sp_executesql @sql,
            N'@id INT, @f_name VARCHAR(50), @l_name VARCHAR(50), @phone INT, @age INT, @Email VARCHAR(250)',
            @id, @f_name, @l_name, @phone, @age, @Email
    END
    ELSE
    BEGIN
        SELECT 'Nurse Not Found' AS Message
    END
END
GO

CREATE PROCEDURE DeleteNurse
@id INT
AS
BEGIN
    
    IF EXISTS(SELECT 1 FROM Nurse WHERE nurse_id = @id)
    BEGIN
        
        DELETE FROM Nurse
        WHERE nurse_id = @id
        
        SELECT 'Nurse deleted successfully' AS Message
    END
    ELSE
    BEGIN
        
        SELECT 'Nurse Not Found' AS Message
    END
END
GO

/* //////////////// Patient Proc //////////////// */

create proc CreatePatient
@f_name varchar(50),
@l_name varchar(50),
@d_of_birth date,
@phone int,
@email varchar(250),
@gen varchar(50),
@rn int
as
begin
	If NOT EXISTS(select email from Patient where email = @email)
	begin
		IF EXISTS(select room_number from Room where room_number = @rn)
		begin
			insert into Patient(first_name, last_name, date_of_birth, phone_number,
								email, gender, room_number)
			values(@f_name, @l_name, @d_of_birth, @phone, @email, @gen, @rn)
			select 'Patient Created successfully.' as Message
		end
		else select 'Room Not Found.' as Message
	end
	else select 'Email is already exist.' as Message
end;
GO

create proc DeletePatient
@id int
as 
begin
		If EXISTS(select @id from Patient where patient_id = @id)
		begin
			delete from Patient where patient_id = @id
			select 'Patient deleted successfully.' as Message
		end

		else select 'Patient not found.' as Message
end;
GO

CREATE PROCEDURE UpdatePatient
    @id INT,
    @f_name VARCHAR(50) = NULL,
    @l_name VARCHAR(50) = NULL,
    @d_of_birth DATE = NULL,
    @phone INT = NULL,
    @email VARCHAR(250) = NULL,
    @gen VARCHAR(50) = NULL,
    @rn INT = NULL
AS
BEGIN
    
    IF NOT EXISTS (SELECT 1 FROM Patient WHERE patient_id = @id)
    BEGIN
        SELECT 'Patient not found.' AS Message
        RETURN
    END

   
    IF @rn IS NOT NULL AND NOT EXISTS (SELECT 1 FROM Room WHERE room_number = @rn)
    BEGIN
        SELECT 'Room not found.' AS Message
        RETURN
    END

   
    IF @email IS NOT NULL AND EXISTS (SELECT 1 FROM Patient WHERE email = @email AND patient_id <> @id)
    BEGIN
        SELECT 'Email already in use by another patient.' AS Message
        RETURN
    END

   
    DECLARE @sql NVARCHAR(MAX) = 'UPDATE Patient SET '
    DECLARE @params NVARCHAR(MAX) = N'@id INT'
    DECLARE @updates NVARCHAR(MAX) = ''
    
    IF @f_name IS NOT NULL
    BEGIN
        SET @updates = @updates + 'first_name = @f_name, '
        SET @params = @params + N', @f_name VARCHAR(50)'
    END

    IF @l_name IS NOT NULL
    BEGIN
        SET @updates = @updates + 'last_name = @l_name, '
        SET @params = @params + N', @l_name VARCHAR(50)'
    END

    IF @d_of_birth IS NOT NULL
    BEGIN
        SET @updates = @updates + 'date_of_birth = @d_of_birth, '
        SET @params = @params + N', @d_of_birth DATE'
    END

    IF @phone IS NOT NULL
    BEGIN
        SET @updates = @updates + 'phone_number = @phone, '
        SET @params = @params + N', @phone INT'
    END

    IF @email IS NOT NULL
    BEGIN
        SET @updates = @updates + 'email = @email, '
        SET @params = @params + N', @email VARCHAR(250)'
    END

    IF @gen IS NOT NULL
    BEGIN
        SET @updates = @updates + 'gender = @gen, '
        SET @params = @params + N', @gen VARCHAR(50)'
    END

    -- Remove the last comma and space
    IF LEN(@updates) > 0
    BEGIN
        SET @updates = LEFT(@updates, LEN(@updates) - 2)
        SET @sql = @sql + @updates + ' WHERE patient_id = @id'

        -- Execute the dynamic SQL
        EXEC sp_executesql @sql, @params, 
            @id = @id, 
            @f_name = @f_name, 
            @l_name = @l_name, 
            @d_of_birth = @d_of_birth, 
            @phone = @phone, 
            @email = @email, 
            @gen = @gen

        SELECT 'Patient updated successfully.' AS Message
    END
    ELSE
    BEGIN
        SELECT 'No changes detected.' AS Message
    END
END
GO

/* //////////////// Room Proc //////////////// */
create proc CreateRoom
@type varchar(75),
@d_id int
as
begin
	If EXISTS(select department_id from Department where department_id = @d_id)
	begin
		insert into Room(type, department_id)
		values(@type, @d_id)
		select 'Room Created successfully.' as Message
	end

	select 'Department Id not found.' as Message
	
end;
GO

create proc DeleteRoom
@id int
as 
begin
		If EXISTS(select room_number from Room where room_number = @id)
		begin
			delete from Room where room_number = @id

			select 'Room deleted successfully.' as Message
		end

		else select 'Room not found.' as Message
end;
GO

create proc UpdateRoom
@id int,
@type varchar(75),
@d_id int
as
begin

	If EXISTS(select room_number from Room where room_number = @id)
	begin
		If EXISTS(select department_id from Department where department_id = @d_id)
		begin
			update Room
			set
				type = @type, 
				department_id = @d_id

			where room_number = @id
			select 'Medication Updated successfully.' as Message
		 end

		else select 'Department not found.' as Message

	end

	else select 'Medication not found.' as Message
end
GO

/* //////////////// Prescription Proc //////////////// */
create proc CreatePrescription
@do varchar(100),
@sd date,
@freq varchar(100),
@ed date,
@did int
as
begin

	IF EXISTS (select 1 from Doctor where doctor_id = @did)
	begin
		insert into Prescription(dosage, start_date, frequency, end_date, doctor_id )
		values(@do, @sd, @freq, @ed, @did)
	end

	else select 'Doctor Id not found' as Message

	select 'Prescription has been created' as Message
end;
GO

CREATE PROCEDURE UpdatePrescription
    @id INT,
    @do varchar(100) = NULL,
	@sd date = NULL,
	@freq varchar(100) = NULL,
	@ed date = NULL
AS
BEGIN
    IF EXISTS(SELECT 1 FROM Prescription WHERE prescription_id = @id)
    BEGIN
        DECLARE @sql NVARCHAR(MAX)
        SET @sql = 'UPDATE Prescription SET '
        
        IF @do IS NOT NULL
        BEGIN
            SET @sql = @sql + 'dosage = @do, '
        END
        
        IF @sd IS NOT NULL
        BEGIN
            SET @sql = @sql + 'start_date = @sd, '
        END
        
        IF @freq IS NOT NULL
        BEGIN
            SET @sql = @sql + 'frequency = @freq, '
        END
        
        IF @ed IS NOT NULL
        BEGIN
            SET @sql = @sql + 'end_date = @ed, '
        END

        -- Remove the trailing comma and space
        SET @sql = LEFT(@sql, LEN(@sql) - 2)
        
        SET @sql = @sql + ' WHERE prescription_id = @id'
        
        -- Execute the dynamic SQL
        EXEC sp_executesql @sql,
            N'@id INT, @do VARCHAR(100), @sd DATE, @freq VARCHAR(100), @ed DATE',
            @id, @do, @sd, @freq, @ed
    END
    ELSE
    BEGIN
        SELECT 'Prescription Not Found' AS Message
    END
END
GO

create proc DeletePrescription
@id int
as 
begin
		If EXISTS(select 1 from Prescription where prescription_id = @id)
		begin
			delete from Prescription where prescription_id = @id

			select 'Prescription deleted successfully.' as Message
		end

		else select 'Prescription not found.' as Message
end;
GO

/* //////////////// Staff Proc //////////////// */
create proc CreateStaff
@f_name varchar(50),
@l_name varchar(50),
@role varchar(50),
@email varchar(250),
@phone varchar(75) = NULL,
@d_id int
as
begin 
	if EXISTS (select 1 from Department where department_id = @d_id)
	begin
		insert into Staff(first_name, last_name, role ,phone, email, department_id)
		values(@f_name, @l_name, @role ,@phone, @email, @d_id)
	end

	else select 'Department Not Found' as Message
end
GO

CREATE PROCEDURE UpdateStaff
    @id INT,
    @f_name varchar(50) = NULL,
	@l_name varchar(50) = NULL,
	@role varchar(50) = NULL,
	@email varchar(250) = NULL,
	@phone varchar(75) = NULL,
	@d_id int = NULL
AS
BEGIN
    IF EXISTS(SELECT 1 FROM Staff WHERE staff_id = @id)
    BEGIN
        DECLARE @sql NVARCHAR(MAX)
        SET @sql = 'UPDATE Staff SET '
        
        IF @f_name IS NOT NULL
        BEGIN
            SET @sql = @sql + 'first_name = @f_name, '
        END
        
        IF @l_name IS NOT NULL
        BEGIN
            SET @sql = @sql + 'last_name = @l_name, '
        END
        
        IF @phone IS NOT NULL
        BEGIN
            SET @sql = @sql + 'phone = @phone, '
        END
        
        IF @email IS NOT NULL
        BEGIN
            SET @sql = @sql + 'email = @email, '
        END
        
        IF @role IS NOT NULL
        BEGIN
            SET @sql = @sql + 'role = @role, '
        END

		IF @d_id IS NOT NULL
        BEGIN
			IF EXISTS (select 1 from Department where department_id = @d_id)
				BEGIN
					SET @sql = @sql + 'department_id = @d_id, '
				END
       
			ELSE 
				BEGIN
					SELECT 'Department Not Found' AS Message
					RETURN
				END
			
        END

        -- Remove the trailing comma and space
        SET @sql = LEFT(@sql, LEN(@sql) - 2)
        
        SET @sql = @sql + ' WHERE staff_id = @id'
        
        -- Execute the dynamic SQL
        EXEC sp_executesql @sql,
            N'@id INT, @f_name VARCHAR(50), @l_name VARCHAR(50), @role VARCHAR(50), @phone varchar(75), @email VARCHAR(250), @d_id INT',
            @id, @f_name, @l_name, @role, @phone, @email, @d_id
    END
    ELSE
    BEGIN
        SELECT 'Staff Not Found' AS Message
    END
END
GO

CREATE PROCEDURE DeleteStaff
@id INT
AS
BEGIN
    
    IF EXISTS(SELECT 1 FROM Staff WHERE staff_id = @id)
    BEGIN
        
        DELETE FROM Staff
        WHERE staff_id = @id
        
        SELECT 'Staff deleted successfully' AS Message
    END
    ELSE
    BEGIN
        
        SELECT 'Staff Not Found' AS Message
    END
END
GO


/* //////////////// Nurse Room Proc //////////////// */

CREATE proc CreateNurseRoom
@rn int,
@nurse_id int,
@h time(7) = NULL
as
begin
	IF EXISTS (select 1 from Nurse where nurse_id = @nurse_id)
	begin
		IF EXISTS (select 1 from Room where room_number = @rn)
		begin
			insert into Nurse_Room(room_number, nurse_id, Hours)
			values(@rn, @nurse_id, @h)

			
		end
		else select 'Room Number Not Found' as Message
	end
	else select 'Nurse Not Found' as Message
end;
GO

CREATE PROCEDURE UpdateNurseRoom
    @current_rn INT,
    @current_nurse_id INT,
    @new_rn INT = NULL,
    @new_nurse_id INT = NULL,
    @new_h TIME(7) = NULL
AS
BEGIN
  
    IF EXISTS (SELECT 1 FROM Nurse_Room WHERE room_number = @current_rn AND nurse_id = @current_nurse_id)
    BEGIN
        DECLARE @sql NVARCHAR(MAX)
        DECLARE @paramDefinition NVARCHAR(MAX)

        SET @sql = N'UPDATE Nurse_Room SET '
        SET @paramDefinition = N'@current_rn INT, @current_nurse_id INT'

        -- Build the dynamic SET clause
        IF @new_rn IS NOT NULL
        BEGIN
            SET @sql = @sql + N'room_number = @new_rn, '
            SET @paramDefinition = @paramDefinition + N', @new_rn INT'
        END

        IF @new_nurse_id IS NOT NULL
        BEGIN
            SET @sql = @sql + N'nurse_id = @new_nurse_id, '
            SET @paramDefinition = @paramDefinition + N', @new_nurse_id INT'
        END

        IF @new_h IS NOT NULL
        BEGIN
            SET @sql = @sql + N'Hours = @new_h, '
            SET @paramDefinition = @paramDefinition + N', @new_h TIME(7)'
        END

        -- Remove the last comma and space
        SET @sql = LEFT(@sql, LEN(@sql) - 2)

       
        SET @sql = @sql + N' WHERE room_number = @current_rn AND nurse_id = @current_nurse_id'

        -- Execute the dynamic SQL
        EXEC sp_executesql @sql,
            @paramDefinition,
            @current_rn = @current_rn,
            @current_nurse_id = @current_nurse_id,
            @new_rn = @new_rn,
            @new_nurse_id = @new_nurse_id,
            @new_h = @new_h
    END
    ELSE
    BEGIN
        SELECT 'Nurse Room combination Not Found' AS Message
    END
END;
GO

create proc DeleteNurseRoom
@rn int,
@nurse_id int
as
begin
	IF EXISTS (select 1 from Nurse where nurse_id = @nurse_id)
	begin
		IF EXISTS (select 1 from Room where room_number = @rn)
		begin
			delete from Nurse_Room
			where room_number = @rn 
			and nurse_id = @nurse_id;
			select 'Nurse Room has been deleted' as Message
		end
		else select 'Room Number Not Found' as Message
	end
	else select 'Nurse Not Found' as Message
end;
GO

/* //////////////// Medical Record Proc //////////////// */

create proc CreateMedicalRecord
@diagnosis varchar(300),
@record_date date,
@treatment varchar(300) = NULL,
@patient_id int,
@doctor_id int
as
begin
	IF EXISTS (select 1 from Patient where patient_id = @patient_id)
	begin
		IF EXISTS (select 1 from Doctor where doctor_id = @doctor_id)
		begin
			insert into Medical_Record (diagnosis, record_date, treatment, patient_id,  doctor_id)
			values(@diagnosis, @record_date, @treatment, @patient_id, @doctor_id)

			select 'Medical Record has been added' as Message
		end
		else select 'Doctor Not Found' as Message
	end
	else select 'Patient Not Found' as Message
end;
GO

CREATE PROCEDURE UpdateMedicalRecord
    @record_id INT,
    @new_diagnosis VARCHAR(300) = NULL,
    @new_record_date DATE = NULL,
    @new_treatment VARCHAR(300) = NULL,
    @new_patient_id INT = NULL,
    @new_doctor_id INT = NULL
AS
BEGIN
    -- Check if the record exists
    IF EXISTS (SELECT 1 FROM Medical_Record WHERE record_id = @record_id)
    BEGIN
        -- Check if the new patient_id exists, if provided
        IF @new_patient_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM Patient WHERE patient_id = @new_patient_id)
        BEGIN
            SELECT 'New Patient Not Found' AS Message
            RETURN
        END
        
        -- Check if the new doctor_id exists, if provided
        IF @new_doctor_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM Doctor WHERE doctor_id = @new_doctor_id)
        BEGIN
            SELECT 'New Doctor Not Found' AS Message
            RETURN
        END

        DECLARE @sql NVARCHAR(MAX)
        DECLARE @paramDefinition NVARCHAR(MAX)

        SET @sql = N'UPDATE Medical_Record SET '
        SET @paramDefinition = N'@record_id INT'

        -- Build the dynamic SET clause
        IF @new_diagnosis IS NOT NULL
        BEGIN
            SET @sql = @sql + N'diagnosis = @new_diagnosis, '
            SET @paramDefinition = @paramDefinition + N', @new_diagnosis VARCHAR(300)'
        END

        IF @new_record_date IS NOT NULL
        BEGIN
            SET @sql = @sql + N'record_date = @new_record_date, '
            SET @paramDefinition = @paramDefinition + N', @new_record_date DATE'
        END

        IF @new_treatment IS NOT NULL
        BEGIN
            SET @sql = @sql + N'treatment = @new_treatment, '
            SET @paramDefinition = @paramDefinition + N', @new_treatment VARCHAR(300)'
        END

        IF @new_patient_id IS NOT NULL
        BEGIN
            SET @sql = @sql + N'patient_id = @new_patient_id, '
            SET @paramDefinition = @paramDefinition + N', @new_patient_id INT'
        END

        IF @new_doctor_id IS NOT NULL
        BEGIN
            SET @sql = @sql + N'doctor_id = @new_doctor_id, '
            SET @paramDefinition = @paramDefinition + N', @new_doctor_id INT'
        END

        -- Remove the last comma and space
        SET @sql = LEFT(@sql, LEN(@sql) - 2)

        -- Add the WHERE clause
        SET @sql = @sql + N' WHERE record_id = @record_id'

        -- Execute the dynamic SQL
        EXEC sp_executesql @sql,
            @paramDefinition,
            @record_id = @record_id,
            @new_diagnosis = @new_diagnosis,
            @new_record_date = @new_record_date,
            @new_treatment = @new_treatment,
            @new_patient_id = @new_patient_id,
            @new_doctor_id = @new_doctor_id

        SELECT 'Medical Record has been updated' AS Message
    END
    ELSE
    BEGIN
        SELECT 'Medical Record Not Found' AS Message
    END
END;
GO


create proc DeleteMedicalRecord
@mr int
as
begin
	IF EXISTS (select 1 from Medical_Record where record_id = @mr )
	begin
			delete from Medical_Record
			where record_id = @mr 

			select 'Medical Record has been deleted' as Message
	end
	else select 'Medical Record Not Found' as Message
end;
GO



