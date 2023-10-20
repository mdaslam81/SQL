   declare @recp_subject      as varchar(150)   = case @test_fl
                                                                    when 'y' then '[TESTONLY]: '
                                                                    else          ''
                                                                   end            +
                                                                   'IWE Maintenance: Building Code Missing Translation (YOU ARE PRIMARY)'
                           ,@recp_body         as varchar(6000)  = 'A jira ticket must be created to correct.'                           + ' ' +
                                                                   'The following building codes are missing a valid translation in the' + ' ' +
                                                                   'dbo.dict_bldg in sait-sqlb.uclanet.ucla.edu:'               +
                                                                   char(13) + char(10)                                                   +
                                                                   char(13) + char(10)                                                   +
                                                                   @missing_building_codes
                           ,@recp_to_list      as varchar(100)   = case @test_fl
                                                                    when 'n' then 'dmorada@sait.ucla.edu;mbjel@sait.ucla.edu'
                                                                    else          'dmorada@sait.ucla.edu;'
                                                                   end 
                           ,@recp_cc_list      as varchar(100)   = case @test_fl
                                                                    when 'n' then ''
                                                                    else          'dmorada@sait.ucla.edu;'
                                                                   end 
	                       ,@donoreply_txt     as varchar(1000)  = '*********************************************************' + char(13) + char(10) +
		                                                           '---------------DO NOT REPLY TO THIS E-MAIL---------------' + char(13) + char(10) +
		                                                           'For questions or changes to this notification,           ' + char(13) + char(10) +
                                                                   '1) e-mail support@sait.ucla.edu                          ' + char(13) + char(10) +
                                                                   '2) use current email Subject as the subject of your email' + char(13) + char(10) +
                                                                   '3) include attachments, if relevant                      ' + char(13) + char(10) +
		                                                           '4) use CC: to copy anyone that should be informed about  ' + char(13) + char(10) +
                                                                   'your request                                             ' + char(13) + char(10) +
		                                                           '---------------DO NOT REPLY TO THIS E-MAIL---------------' + char(13) + char(10) +
		                                                           '*********************************************************'
            	
                    --declare and set notification variables
                    select @recp_body = @donoreply_txt      + 
                                        char(13) + char(10) +
                                        char(13) + char(10) +
                                        @recp_body  
                   

	            
                    --command to send notification
                    exec msdb.dbo.sp_send_dbmail @profile_name      = 'NoReply'
                                                ,@recipients        = @recp_to_list
                                                ,@copy_recipients   = @recp_cc_list
                                                ,@subject           = @recp_subject
                                                ,@body              = @recp_body   