# Test Plan
## Test Case: Create new bussiness account happy path

1. Step: Navigate to <site>  
   Expected: <Site> is open on the login page
2. Step: Click on "You don't have an account Get started here" link
   Expected: Syste shall load the register bussiness account page and display the create account form 
3. Step: Verify the form
	Expected:   system shall display for the form:
	            First name, Last name, Company Name, Job Title, Phone number, bussiness email, passsword fields
			   	Accept Privacy and Terms and condition checkbox
				"Sign Up" button
4. Step: Complete all fields with valid data:
   First Name: TestName
   Last Name: TestLastName
   Company Name: Test Company Name
   Job Title: TestJobTitle
   Phone Number: 666666666
   Bussiness Mail: test@signaturit.com
   Password #A123456
5. Step: click on the privacy and T&Ccheckbox to set it true
6. Step: Click on Sign Up Now Button 
   Expected:  System shall process the sign up and display a welcome message         


## Test Case: Create new bussiness account with non numeric phone
1. Step: Navigate to <site>  
   Expected: <Site> is open on the login page
2. Step: Click on "You don't have an account Get started here" link
   Expected: Syste shall load the register bussiness account page and display the create account form 
3. Step: Verify the form
	Expected:   system shall display for the form:
	            First name, Last name, Company Name, Job Title, Phone number, bussiness email, passsword fields
			   	Accept Privacy and Terms and condition checkbox
				"Sign Up" button
4. Step: Complete all fields with valid data:
   First Name: TestName
   Last Name: TestLastName
   Company Name: Test Company Name
   Job Title: TestJobTitle
   Phone Number: AAABBCCDD
   Bussiness Mail: test@signaturit.com
   Password #A123456
5. Step: click on the privacy and T&Ccheckbox to set it true
6. Step: Click on Sign Up Now Button 
   Expected: System shall display an error message about the format of the Phone Number field
   
## Test Case: Create new bussiness account with non valid email
1. Step: Navigate to <site>  
   Expected: <Site> is open on the login page
2. Step: Click on "You don't have an account Get started here" link
   Expected: Syste shall load the register bussiness account page and display the create account form 
3. Step: Verify the form
	Expected:   system shall display for the form:
	            First name, Last name, Company Name, Job Title, Phone number, bussiness email, passsword fields
			   	Accept Privacy and Terms and condition checkbox
				"Sign Up" button
4. Step: Complete all fields with valid data:
   First Name: TestName
   Last Name: TestLastName
   Company Name: Test Company Name
   Job Title: TestJobTitle
   Phone Number: 666666666
   Bussiness Mail: test@signaturit.
   Password: #A123456
5. Step: click on the privacy and T&Ccheckbox to set it true
6. Step: Click on Sign Up Now Button    
   Expected: System shall display an error message about the email is not valid

## Execution instructions

From console run:
- rvm use 2.4.5 
- gem install bundler 
- gem install yard 
- gem install watir 
- bundler install
run "rake default --trace
run  "rake default --trace"      

           
**Available tags**           
@exercise 
