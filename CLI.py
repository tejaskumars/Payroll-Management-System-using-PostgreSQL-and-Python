import psycopg2


conn=psycopg2.connect(database="payroll",user="postgres",password="Tejas@#123")
cur=conn.cursor()

def view_company():
	cur.execute("SELECT * FROM COMPANY")
	rows=cur.fetchall()
	for i in rows:
		print(f"comp_id {i[0]} comp_addr {i[1]} comp_name {i[2]} comp_number {i[3]}")
		
def add_comp(a,b,c,d):
	cur.execute("INSERT INTO COMPANY(comp_id,comp_name,comp_addr,comp_number) VALUES (%s,%s,%s,%s)",(a,b,c,d))
	print("Insert Complete")
	print("Updated details \n")
	view_company()
	
	
def view_employee():
	cur.execute("SELECT * FROM EMPLOYEE")
	rows=cur.fetchall()
	for i in rows:
		print(f"employee_id {i[0]},fname {i[1]},mname {i[2]},lname {i[3]},gender {i[4]},dob {i[5]},doj {i[6]},age {i[7]},comp_name {i[8]},dept_name {i[9]},job_title {i[10]},ph_no {i[11]},project_title {i[12]},address {i[13]},pincode {i[14]})")
				
		
def view_paygrade(a):
	cur.execute("SELECT * FROM PAYGRADE WHERE (employee_id=%s)",([a]))		
	rows=cur.fetchall()
	for  i in rows:	
		print(i)
		
		
		
print("Please select operation -\n" \
        "1. view_company\n" \
        "2. add_company\n" \
        "3. view_employee_details\n" \
        "4. view_paygrade(as per employee ID)\n")
        
  
  
# Take input from the user 
select = int(input("Select operations form 1, 2, 3, 4 :"))

if select==1:
	view_company();
elif select==2:
	print("enter comp_id,comp_name,comp_addr,comp_number in order... ")
	comp_id=int(input())
	comp_name=input()
	comp_addr=input()
	comp_number=int(input())
	add_comp(comp_id,comp_name,comp_addr,comp_number)

elif select==3:
	view_employee();
	
else:
	Id=int(input("enter emp_id: "))
	view_paygrade(Id);
	
  


cur.close()

conn.close()
