 -- Cursor variables
 DECLARE @table_name NVARCHAR(255);
 DECLARE @master_records INT;
 DECLARE @secondary_record INT;
 DECLARE @equal_flag NVARCHAR(50);

 DECLARE cur CURSOR FOR
     SELECT table_name, master_records, secondary_record, equal_flag
     FROM policy_mail;

 OPEN cur;
 FETCH NEXT FROM cur INTO @table_name, @master_records, @secondary_record, @equal_flag;

 WHILE @@FETCH_STATUS = 0
 BEGIN
     SET @MailMessage = @MailMessage + 
         '<tr><td>' + ISNULL(@table_name, '') + 
         '</td><td>' + CAST(ISNULL(@master_records, 0) AS NVARCHAR) + 
         '</td><td>' + CAST(ISNULL(@secondary_record, 0) AS NVARCHAR) + 
         '</td><td>' + ISNULL(@equal_flag, '') + 
         '</td></tr>';

     FETCH NEXT FROM cur INTO @table_name, @master_records, @secondary_record, @equal_flag;
 END

 CLOSE cur;
 DEALLOCATE cur;
