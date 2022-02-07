drop database payroll;
CREATE DATABASE PAYROLL;

\c payroll

CREATE TABLE users(
	user_id INT NOT NULL UNIQUE,
	username VARCHAR(30) NOT NULL,
	password VARCHAR(30),
	email_id VARCHAR(60) UNIQUE,
	user_type VARCHAR(30) DEFAULT 'ADMIN',
	
CONSTRAINT PK_users PRIMARY KEY(user_id)
);

CREATE  TABLE company(

	comp_id INT NOT NULL UNIQUE,
	comp_addr VARCHAR(50) NOT NULL,
	comp_name VARCHAR(50) NOT NULL unique,
	comp_number BIGINT,
	
CONSTRAINT PK_company PRIMARY KEY(comp_id)
);

CREATE TABLE department(

	dept_id INT NOT NULL UNIQUE,
	dept_name VARCHAR(30) NOT NULL UNIQUE,
	comp_name varchar(30) not null,
	dept_size int not null,
	dept_roomno int not null,
	dept_head varchar(30) not null,
	
CONSTRAINT PK_department PRIMARY KEY(dept_id),
CONSTRAINT FK_comp_name FOREIGN KEY(comp_name) references company(comp_name)
);

CREATE TABLE project(

	project_id INT NOT NULL UNIQUE,
	project_title VARCHAR NOT NULL UNIQUE,
	due_date date,
	
CONSTRAINT PK_project PRIMARY KEY(project_id)
);

CREATE TABLE employee(

	employee_id INT NOT NULL UNIQUE,
	fname VARCHAR(30) NOT NULL,
	mname VARCHAR(30) NOT NULL,
	lname VARCHAR(30) NOT NULL,
	gender char(1) NOT NULL,
	dob DATE CHECK ( DOB > '1975-01-01' and dob < '2000-01-01'),
	doj DATE CHECK ( DOJ > DOB),
	age INT,
	comp_name varchar(30),
	dept_name VARCHAR(30),
	job_title VARCHAR(30),
	ph_no BIGINT NOT NULL UNIQUE,
	project_title VARCHAR(30),
	address VARCHAR(50),
	pincode INT,
	
CONSTRAINT PK_employee PRIMARY KEY(employee_id),
FOREIGN KEY(comp_name) references company(comp_name),
FOREIGN KEY(dept_name) references department(dept_name),
FOREIGN KEY(project_title) references project(project_title)
);


CREATE TABLE bank_account(

	account_number INT NOT NULL UNIQUE,
	beneficiary_name VARCHAR(30)  NOT NULL,
	remitter_name VARCHAR(30)  NOT NULL,
	employee_id INT NOT NULL,
	transaction_id INT NOT NULL UNIQUE,
	date_of_transaction DATE NOT NULL,
	amount_transferred INT NOT NULL,
	
CONSTRAINT PK_bank_account PRIMARY KEY(account_number),
FOREIGN KEY(employee_id) references employee(employee_id)
);

CREATE TABLE paygrade(

	paygrade_id INT NOT NULL UNIQUE,
	employee_id INT NOT NULL,
	job_title VARCHAR(30) NOT NULL,
	job_grade VARCHAR(10) NOT NULL,
	basic_salary INT CHECK ( basic_salary > 0),
	bonus INT,
	taxes INT,
	penalties INT,
	final_salary INT,
	allowances INT,
	total_amount INT NOT NULL,
	
CONSTRAINT PK_paygrade PRIMARY KEY(paygrade_id),
FOREIGN KEY(employee_id) references employee(employee_id)
);

CREATE TABLE payroll(

	payroll_id INT NOT NULL UNIQUE,
	employee_id INT NOT NULL UNIQUE,
	transaction_id INT NOT NULL,
	account_number INT NOT NULL,
	date_of_transaction DATE NOT NULL,
	payroll_report VARCHAR(100) NOT NULL,
	total_amount INT NOT NULL,
	
CONSTRAINT PK_payroll PRIMARY KEY (payroll_id),
FOREIGN KEY(employee_id) references employee(employee_id),
FOREIGN KEY(transaction_id) references bank_account(transaction_id),
FOREIGN KEY(account_number) references bank_account(account_number)
);
