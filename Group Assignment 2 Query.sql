DROP TABLE ActivityParticipant;
DROP TABLE EmployeeProgram;
DROP TABLE AssignedEmployee;
DROP TABLE ProgramActivity;
DROP TABLE Appointment;
DROP TABLE ProgramParticipant;
DROP TABLE PersonalTrainer;
DROP TABLE CampusInvolvement;
DROP TABLE JobRole;
DROP TABLE Program;
DROP TABLE PayRaise;
DROP TABLE Employee;
DROP TABLE PreviousJob;
DROP TABLE Certification;
DROP TABLE Alumni;
DROP TABLE Position;
DROP TABLE Applicant;

CREATE TABLE Applicant (
	ApplicantID				INT PRIMARY KEY,
	AppFirstName			VARCHAR(20)			NOT NULL,
	AppLastName				VARCHAR(20)			NOT NULL,
	AppMiddleInitial		CHAR(1),
	AppStreetAddress		VARCHAR(30)			NOT NULL,
	AppCity					VARCHAR(30)			NOT NULL,
	AppState				CHAR(2)				NOT NULL,
	AppZipCode				CHAR(5)				NOT NULL,
	PrimaryPhoneNum			CHAR(12)			NOT NULL,
	AltPhoneNum				CHAR(12),
	Email					VARCHAR(30)			NOT NULL,
	PermStreetAddress		VARCHAR(30),
	PermCity				VARCHAR(30),
	PermState				CHAR(2),
	PermZipCode				CHAR(5),
	PermHomeNum				CHAR(12),
	PermCellPhoneNum		CHAR(12),
	PermEmail				VARCHAR(30),
	EmergFirstName			VARCHAR(20),
	EmergLastName			VARCHAR(20),
	EmergMiddleInitial		CHAR(1),
	EmergStreetAddress		VARCHAR(30),
	EmergCity				VARCHAR(30),
	EmergState				CHAR(2),
	EmergZipCode			CHAR(5),
	EmergHomePhoneNum		CHAR(12),
	EmergCellPhoneNum		CHAR(12),
	EmergEmail				VARCHAR(30),
	Date					DATE				NOT NULL	DEFAULT GETDATE(),
	Major					VARCHAR(15)			NOT NULL,
	ExpGraduationDate		DATE				NOT NULL,
	GPA						DECIMAL(3,2)		NOT NULL	CHECK(GPA > 0),
	Semester				VARCHAR(6)			NOT NULL,
	DesiredHours			INT					NOT NULL	CHECK(DesiredHours > 0),
	EarlyMorningAvail		VARCHAR(3)			NOT NULL,	CHECK(EarlyMorningAvail IN ('Yes', 'No')),
	NightAvail				VARCHAR(3)			NOT NULL,	CHECK(NightAvail IN ('Yes', 'No')),
	Essay1Completion		VARCHAR(3)			NOT NULL,	CHECK(Essay1Completion IN ('Yes', 'No')),
	Essay2Completion		VARCHAR(3)			NOT NULL,	CHECK(Essay2Completion IN ('Yes', 'No')),
	SummerAvail				VARCHAR(3)			NOT NULL,	CHECK(SummerAvail IN ('Yes', 'No')),
	Schedule				VARCHAR(75)			NOT NULL,
	Comment					VARCHAR(75),
	InterviewYN				VARCHAR(3)			NOT NULL	CHECK(InterviewYN IN ('Yes', 'No')),
	InterviewDate			DATE,
	ScreenedOutYN			VARCHAR(3)			NOT NULL	CHECK(ScreenedOutYN IN ('Yes', 'No')),
	HiredYN					VARCHAR(3)			NOT NULL	CHECK(HiredYN IN ('Yes', 'No')),
	Program					VARCHAR(20),
	ApplicantType			VARCHAR(8)			NOT NULL	CHECK(ApplicantType IN ('Employee', 'Alumni'))
);

CREATE TABLE Position (
	PositionID				INT PRIMARY KEY,
	Title					VARCHAR(30)			NOT NULL,
	ApplicantID				INT					NOT NULL,
	CONSTRAINT				PositionApplicantFK FOREIGN KEY (ApplicantID) REFERENCES Applicant (ApplicantID)
		ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE Alumni (
	AlumniApplicantID		INT PRIMARY KEY,
	ReasonForLeaving		VARCHAR(30),
	GraduationDate			DATE				NOT NULL,
	ExitInterviewComment	VARCHAR(30)
);

CREATE TABLE Certification (
	CertificationID			INT PRIMARY KEY,
	ExpirationDate			DATE,
	ApplicantID				INT					NOT NULL,
	CONSTRAINT				CertificationApplicantFK FOREIGN KEY (ApplicantID) REFERENCES Applicant (ApplicantID)
		ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE PreviousJob (
	JobID					INT PRIMARY KEY,
	PreviousPosition		VARCHAR(20)			NOT NULL,
	Company					VARCHAR(20)			NOT NULL,
	SupervisFirstName		VARCHAR(20)			NOT NULL,
	SupervisLastName		VARCHAR(20)			NOT NULL,
	PhoneNum				CHAR(12)			NOT NULL,
	PJStartDate				DATE				NOT NULL,
	PJEndDate				DATE,
	ApplicantID				INT					NOT NULL,
	CONSTRAINT				PreviousJobApplicantFK FOREIGN KEY (ApplicantID) REFERENCES Applicant (ApplicantID)
		ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE Employee (
	EmployeeApplicantID		INT PRIMARY KEY,
	StartPayRate			MONEY				NOT NULL	CHECK(StartPayRate > 0),
	ShirtSize				VARCHAR(5)			NOT NULL,
	JobRole					VARCHAR(75)			NOT NULL,
	AccessLevel				VARCHAR(20)			NOT NULL,
	Position				VARCHAR(20)			NOT NULL
);
CREATE TABLE PayRaise (
	PayRaiseID				INT PRIMARY KEY,
	PayRaiseAmount			MONEY				NOT NULL	CHECK(PayRaiseAmount > 0),
	PayRaiseDate			DATE				NOT NULL	CHECK(PayRaiseDate < GETDATE()-1),
	Evaluation				VARCHAR(30)			NOT NULL,
	EmployeeApplicantID		INT					NOT NULL,
	CONSTRAINT				PayRaiseEmployeeFK FOREIGN KEY (EmployeeApplicantID) REFERENCES Employee (EmployeeApplicantID)
		ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE Program (
	ProgramID				INT PRIMARY KEY,
	ProgramName				VARCHAR(30)			NOT NULL,
	ProgramDescription		VARCHAR(75)			NOT NULL
);

CREATE TABLE JobRole (
	JobRoleID				INT PRIMARY KEY,
	JobRoleName				VARCHAR(75)			NOT NULL,
	EmployeeApplicantID		INT					NOT NULL,
	ProgramID				INT					NOT NULL,
	CONSTRAINT				JobRoleEmployeeFK FOREIGN KEY (EmployeeApplicantID) REFERENCES Employee (EmployeeApplicantID)
		ON UPDATE CASCADE ON DELETE NO ACTION,
	CONSTRAINT				JobRoleProgramFK FOREIGN KEY (ProgramID) REFERENCES Program (ProgramID)
		ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE CampusInvolvement (
	ActivityID				INT PRIMARY KEY,
	ActivityName			VARCHAR(30)			NOT NULL,
	EmployeeApplicantID		INT					NOT NULL,
	CONSTRAINT				CampusInvolementEmployeeFK FOREIGN KEY (EmployeeApplicantID) REFERENCES Employee (EmployeeApplicantID)
		ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE PersonalTrainer (
	TrainerID				INT PRIMARY KEY,
	StandardRate			MONEY				NOT NULL	CHECK(StandardRate > 0),
	TotalHoursPerWeek		INT					NOT NULL	CHECK(TotalHoursPerWeek > 0),
	EmployeeApplicantID		INT,
	CONSTRAINT				PersonalTrainerEmployeeFK FOREIGN KEY (EmployeeApplicantID) REFERENCES Employee (EmployeeApplicantID)
		ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE ProgramParticipant (
	ParticipantID			INT PRIMARY KEY,
	ParticFirstName			VARCHAR(20)			NOT NULL,
	ParticLastName			VARCHAR(20)			NOT NULL,
	ParticStreet			VARCHAR(30)			NOT NULL,
	ParticCity				VARCHAR(30)			NOT NULL,
	ParticState				CHAR(2)				NOT NULL,
	ParticZipCode			CHAR(5)				NOT NULL,
	ParticPhoneNum			CHAR(12)			NOT NULL,
	Gender					VARCHAR(6)			NOT NULL	CHECK(Gender IN ('Male', 'Female')),
	BirthDate				DATE				NOT NULL,
	JoinDate				DATE				NOT NULL	DEFAULT GETDATE()
);

CREATE TABLE Appointment (
	TrainerID				INT,
	ParticipantID			INT,
	Payment					MONEY				NOT NULL	CHECK(Payment > 0),
	CONSTRAINT				AppointmentPK PRIMARY KEY (TrainerID, ParticipantID)
);	

CREATE TABLE ProgramActivity (
	ProgramActivityID		INT PRIMARY KEY,
	PAStartDate				DATE				NOT NULL,
	PAEndDate				DATE,
	AdditionalCost			MONEY				CHECK(AdditionalCost > 0),
	ProgramID				INT,
	CONSTRAINT				ProgramActivityProgramFK FOREIGN KEY (ProgramID) REFERENCES Program (ProgramID)
		ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE AssignedEmployee (
	EmployeeApplicantID		INT,
	ProgramActivityID		INT,
	CONSTRAINT				AssignedEmployeePK PRIMARY KEY (EmployeeApplicantID, ProgramActivityID)
);

CREATE TABLE EmployeeProgram (
	EmployeeApplicantID		INT,
	ProgramID				INT,
	AverageHoursPerWeek		INT,
	HiringLeads		VARCHAR(30),
	Progression		VARCHAR(30),
	CONSTRAINT				EmployeeProgramPK PRIMARY KEY (EmployeeApplicantID, ProgramID)
);

CREATE TABLE ActivityParticipant (
	ParticipantID			INT,
	ProgramActivityID		INT,
	EnrollmentDate			DATE				NOT NULL,
	EnrollmentTime			TIME				NOT NULL,
	CONSTRAINT				ActivityParticipantPK PRIMARY KEY (ParticipantID, ProgramActivityID)
);

INSERT INTO Applicant VALUES (100001, 'Jackson', 'Richards', 'S', '263 Parker Ave.', 'Twin Falls', 'ID', '83301', '495-686-2938', NULL, 'jrichards@gmail.com', NULL, NULL, NULL, NULL, NULL, '495-686-2938', 'jrichards@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '03/04/2023', 'Finance', '05/17/2023', 3.65, 'Summer', 40, 'Yes', 'No', 'Yes', 'No', 'Yes', 'N/A', NULL, 'Yes', '03/23/2023', 'Yes', 'Yes', 'Basketball', 'Employee');
INSERT INTO Applicant VALUES (100002, 'Paul', 'Smith', 'H', '13 Brown St.', 'New City', 'NY' , '10956', '104-820-1183', NULL, 'psmith@gmail.com', NULL, NULL, NULL, NULL, NULL, '104-820-1183', 'psmith@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01/22/2023', 'Finance', '05/17/2023', 3.23, 'Summer', 40, 'Yes', 'Yes', 'Yes', 'Yes', 'Yes', 'N/A', NULL, 'Yes', '02/01/2023', 'Yes', 'No', NULL, 'Alumni');
INSERT INTO Applicant VALUES (100003, 'Leah', 'Jones', NULL, '319 Lafayette Drive', 'Riverdale', 'GA', '30274', '294-594-5922', NULL, 'ljones@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, 'ljones@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '03/01/2023', 'Psychology', '05/17/2023', 3.44, 'Fall', 35, 'Yes', 'Yes', 'Yes', 'Yes', 'No', 'November 15th - November 30th', NULL, 'Yes', '03/18/2023', 'No', 'No', NULL, 'Alumni');
INSERT INTO Applicant VALUES (100004, 'Hannah', 'Sanders', 'D', '8753 Studebaker Dr.', 'Greensboro', 'NC', '27405', '220-459-7934', NULL, 'hsanders@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '03/03/2023', 'Biology', '05/17/2023', 3.81, 'Winter', 40, 'No', 'Yes', 'Yes', 'Yes', 'Yes', 'N/A', NULL, 'Yes', '03/21/2023', 'No', 'No', NULL, 'Alumni');
INSERT INTO Applicant VALUES (100005, 'Frank', 'Johnson', 'C', '925 Manhattan Road', 'Key West', 'FL', '33040', '943-986-5427', NULL, 'fjohnson@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '02/12/2023', 'Communications', '05/17/2023', 3.59, 'Summer', 30, 'No', 'Yes', 'Yes', 'No', 'Yes', 'August 1st - August 7th', NULL, 'No', NULL, 'Yes', 'Yes', 'Yoga', 'Employee');
INSERT INTO Applicant VALUES (100006, 'Anthony', 'Adams', 'A', '34 Gainsway St.', 'Merrick', 'NY', '11566', '359-982-2483', NULL, 'aadams@gmail.com', NULL, NULL, NULL, NULL, NULL, '359-982-2483', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '02/21/2023', 'Accounting', '05/17/2023', 3.99, 'Summer', 40, 'Yes', 'Yes', 'No', 'No', 'Yes', 'N/A', NULL, 'Yes', '03/12/2023', 'Yes', 'Yes', 'Volleyball', 'Employee');
INSERT INTO Applicant VALUES (100007, 'Jessica', 'Norris', 'R', '611 Elizabeth Ave.', 'Roy', 'UT', '84067', '491-306-4290', NULL, 'jnorris@gmail.com', NULL, NULL, NULL, NULL, NULL, '491-306-4290', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01/28/2023', 'Chemistry', '05/17/2023', 3.85, 'Summer', 40, 'No', 'Yes', 'Yes', 'Yes', 'Yes', 'N/A', NULL, 'Yes', '02/04/2023', 'Yes', 'Yes', 'Swimming', 'Alumni');
INSERT INTO Applicant VALUES (100008, 'Abby', 'Reed', 'T', '710 Ridge Drive', 'Lacey', 'WA', '98503', '540-286-0296',  '540-145-1211', 'areed@gmail.com', NULL, NULL, NULL, NULL, '240-138-2222', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '12/29/2022', 'Marketing', '05/17/2023', 3.16, 'Spring', 37, 'Yes', 'Yes', 'Yes', 'Yes', 'No', 'N/A', NULL, 'Yes', '01/10/2023', 'No', 'No', NULL, 'Alumni');
INSERT INTO Applicant VALUES (100009, 'Dennis', 'Brown', 'N', '365 San Carlos Ave.', 'Vienna', 'VA', '22180', '653-238-0937', NULL, 'dbrown@gmail.com', '9 Strawberry Court', 'Yorktown', 'VA', '23693', NULL, '653-238-0937', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '03/19/2023', 'Accounting', '05/17/2023', 3.64, 'Fall', 32, 'Yes', 'Yes', 'Yes', 'Yes', 'Yes', 'N/A', NULL, 'No', NULL, 'Yes', 'Yes', 'Weightlifting', 'Alumni');
INSERT INTO Applicant VALUES (100010, 'Allen', 'Jenkins', NULL, '749 Swanson Rd.', 'North Bergen', 'NJ', '07047', '239-584-8420', NULL, 'ajenkins@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '12/30/2023', 'Astronomy', '05/17/2024', 3.22, 'Summer', 35, 'Yes', 'Yes', 'Yes', 'Yes', 'Yes', 'N/A', NULL, 'Yes', '01/09/2023', 'Yes', 'No', NULL, 'Employee');
INSERT INTO Applicant VALUES (100011, 'Stephen', 'Davis', 'G', '659 Temple Street', 'Nanuet', 'NY', '10954', '245-219-6935', NULL, 'sdavis@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01/09/2023', 'Management', '05/17/2024', 3.74, 'Winter', 40, 'Yes', 'No', 'Yes', 'No', 'No', 'N/A', NULL, 'No', NULL, 'Yes', 'Yes', 'Football', 'Alumni');
INSERT INTO Applicant VALUES (100012, 'Will', 'Simpson', 'M', '470 Cedar Road', 'Beltsville', 'MD', '20705', '520-913-9943', NULL, 'wsimpson@gmail.com', '712 Overlook Drive', 'Pasadena', 'MD', '21122', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '03/06/2023', 'Mathematics', '05/17/2024', 3.45, 'Spring', 38, 'Yes', 'No', 'Yes', 'Yes', 'Yes', 'April 3rd - April 10th', NULL, 'Yes', '03/23/2023', 'Yes', 'Yes', 'Soccer', 'Employee');
INSERT INTO Applicant VALUES (100013, 'Joe', 'Miller', NULL, '19 3rd Drive', 'Venice', 'FL', '34293', '440-239-1945', '440-222-7591', 'jmiller@gmail.com', NULL, NULL, NULL, NULL, '443-245-9090', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01/13/2023', 'Supply Chain', '05/17/2024', 3.41, 'Summer', 40, 'No', 'Yes', 'Yes', 'Yes', 'Yes', 'N/A', NULL, 'Yes', '01/29/2023', 'No', 'No', NULL, 'Alumni');
INSERT INTO Applicant VALUES (100014, 'Olivia', 'Carter', 'L', '417 Dunbar St.', 'Parkville', 'MD', '21234', '345-020-3966', NULL, 'ocarter@gmail.com', NULL, NULL, NULL, NULL, NULL, '345-020-3966', NULL,  NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '02/27/2023', 'Marketing', '05/17/2024', 3.96, 'Fall', 40, 'Yes', 'Yes', 'Yes', 'Yes', 'No', 'N/A', NULL, 'Yes', '03/11/2023', 'Yes', 'Yes', 'CrossFit', 'Employee');
INSERT INTO Applicant VALUES (100015, 'Madison', 'Roberts', 'K', '24 Miller Drive', 'Coatesville', 'PA', '19320', '837-195-5529', NULL, 'mcarter@gmail.com', NULL, NULL, NULL, NULL, NULL, '837-195-5529', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '12/16/2022', 'Economics', '05/17/2024', 3.76, 'Summer', 40, 'Yes', 'Yes', 'Yes', 'Yes', 'Yes', 'N/A', NULL, 'Yes', '01/03/2023', 'Yes', 'Yes', 'Basketball', 'Alumni');
INSERT INTO Applicant VALUES (100016, 'Elizabeth', 'Harris', 'J', '967 Wood St.', 'Suwanee', 'GA', '30024', '342-324-1494', NULL, 'eharris@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL,  NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '12/20/2022', 'Geology', '05/17/2024', 3.72, 'Summer', 35, 'No', 'Yes', 'Yes', 'No', 'Yes', 'N/A', NULL, 'No', NULL, 'Yes', 'Yes', 'Softball', 'Employee');
INSERT INTO Applicant VALUES (100017, 'Greg', 'Rose', 'B', '92 Galvin Dr.', 'Wilson', 'NC', '27893', '449-229-5955', '449-132-9923', 'grose@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01/02/2023', 'Nursing', '05/17/2024', 3.84, 'Summer', 30, 'Yes', 'Yes', 'Yes', 'Yes', 'Yes', 'N/A', NULL, 'Yes', '01/15/2023', 'Yes', 'Yes', 'Baseball', 'Alumni');
INSERT INTO Applicant VALUES (100018, 'Brad', 'Lewis', NULL, '390 Glen Ridge St.', 'Irwin', 'PA', '15642', '555-139-4596', NULL, 'blewis@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Molly', 'Lewis', 'N', '7303 Chapel St.', 'Trumbull', 'CT', '06611', '666-242-2456', '111-222-4545', 'mlewis@gmail.com', '02/09/2023', 'Sociology', '05/17/2024', 3.35, 'Summer', 34, 'Yes', 'Yes', 'Yes', 'Yes', 'Yes', 'N/A', NULL, 'Yes', '02/20/2023', 'Yes', 'Yes', 'Weightlifting', 'Employee');
INSERT INTO Applicant VALUES (100019, 'David', 'Garcia', 'F', '119 Greystone Dr.', 'Shirley', 'NY', '11967', '990-242-3344', NULL, 'dgarcia@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Jeff', 'Garcia', 'H', '46 Euclid Drive', 'Shirley', 'NY', '11967', '888-222-1334', '999-345-0003', 'jgarcia@gmail.com', '03/24/2023', 'Philosophy', '05/17/2024', 3.39, 'Winter', 40, 'No', 'Yes', 'Yes', 'Yes', 'No', 'N/A', NULL, 'Yes', '03/29/2023', 'Yes', 'Yes', 'Volleyball', 'Employee');
INSERT INTO Applicant VALUES (100020, 'Patrick', 'Hill', 'W', '882 E. Eagle St.', 'Ridgecrest', 'CA', '93555', '249-664-2592', NULL, 'phill@gmail.com', NULL, NULL, NULL, NULL, '787-999-6789', NULL, NULL, 'Jonah', 'Hill', 'S', '8263 Grant Court', 'Santa Clara', 'CA', '95050', '212-212-2122', '900-343-5915', 'jhill@gmail.com', '02/15/2023', 'Finance', '05/17/2024', 3.52, 'Summer', 40, 'Yes', 'No', 'Yes', 'Yes', 'Yes', 'N/A', NULL, 'Yes', '02/25/2023', 'Yes', 'Yes', 'Swimming', 'Employee');

INSERT INTO Position VALUES (200001, 'Manager', 100001);
INSERT INTO Position VALUES (200002, 'Assistant Manager', 100005);
INSERT INTO Position VALUES (200003, 'Referee', 100006);
INSERT INTO Position VALUES (200004, 'Trainer', 100007);
INSERT INTO Position VALUES (200005, 'Coach', 100009);
INSERT INTO Position VALUES (200006, 'Instructor', 100011);
INSERT INTO Position VALUES (200007, 'Scorekeeper', 100012);
INSERT INTO Position VALUES (200008, 'Supervisor', 100014);
INSERT INTO Position VALUES (200009, 'Consultant', 100015);
INSERT INTO Position VALUES (200010, 'Director', 100016);
INSERT INTO Position VALUES (200011, 'Physical Therapist', 100017);
INSERT INTO Position VALUES (200012, 'Assistant Supervisor', 100018);
INSERT INTO Position VALUES (200013, 'Assistant Director', 100019);
INSERT INTO Position VALUES (200014, 'Lifeguard', 100020);

INSERT INTO Alumni VALUES (300001, NULL, '05/17/2022', NULL);
INSERT INTO Alumni VALUES (300002, NULL, '05/17/2022', NULL);
INSERT INTO Alumni VALUES (300003, 'Better options for me', '05/17/2021', 'I will miss the program');
INSERT INTO Alumni VALUES (300004, NULL, '05/17/2022', NULL);
INSERT INTO Alumni VALUES (300005, NULL, '05/17/2021', NULL);
INSERT INTO Alumni VALUES (300006, NULL, '05/17/2021', NULL);
INSERT INTO Alumni VALUES (300007, NULL, '05/17/2022', NULL);
INSERT INTO Alumni VALUES (300008, NULL, '05/17/2021', NULL);
INSERT INTO Alumni VALUES (300009, 'Found a new job elsewhere', '05/17/2022', NULL);
INSERT INTO Alumni VALUES (300010, NULL, '05/17/2022', NULL);

INSERT INTO Certification VALUES (400001, NULL, 100007);
INSERT INTO Certification VALUES (400002, NULL, 100009);
INSERT INTO Certification VALUES (400003, '08/26/2030', 100011);
INSERT INTO Certification VALUES (400004, NULL, 100012);
INSERT INTO Certification VALUES (400005, '11/08/2030', 100014);
INSERT INTO Certification VALUES (400006, NULL, 100015);
INSERT INTO Certification VALUES (400007, NULL, 100016);
INSERT INTO Certification VALUES (400008, NULL, 100018);
INSERT INTO Certification VALUES (400009, NULL, 100019);
INSERT INTO Certification VALUES (400010, '12/31/2030', 100020);

INSERT INTO PreviousJob VALUES (500001, 'Director', 'Nike', 'Jim', 'Jones', '999-999-9999', '09/08/2018', '09/03/2021', 100001);
INSERT INTO PreviousJob VALUES (500002, 'Manager', 'Adidas', 'Jenna', 'Smith', '888-888-8888', '05/12/2019', '09/11/2022', 100002);
INSERT INTO PreviousJob VALUES (500003, 'Assistant Manager', 'Chipotle', 'David', 'Johnson', '777-777-7777', '04/18/2017', '12/29/2020', 100003);
INSERT INTO PreviousJob VALUES (500004, 'Lifeguard', 'YMCA', 'Wayne', 'Stevens', '666-666-6666', '03/01/2016', '07/15/2022', 100004);
INSERT INTO PreviousJob VALUES (500005, 'Referee', 'YMCA', 'Eric', 'Kendricks', '777-367-0099', '11/12/2020', '02/05/2022', 100005);
INSERT INTO PreviousJob VALUES (500006, 'Advisor', 'Under Armour', 'Landon', 'Sanders', '123-123-0987', '06/18/2019', '05/13/2021', 100006);
INSERT INTO PreviousJob VALUES (500007, 'Coach', 'YMCA', 'Adam', 'Wade', '440-004-0660', '01/06/2020', '10/07/2022', 100007);
INSERT INTO PreviousJob VALUES (500008, 'Trainer', 'YMCA', 'Hunter', 'White', '505-555-9999', '04/04/2018', '05/25/2021', 100008);
INSERT INTO PreviousJob VALUES (500009, 'Instructor', 'YMCA', 'Rachel', 'Lee', '555-555-5555', '10/29/2020', '12/12/2022', 100009);
INSERT INTO PreviousJob VALUES (500010, 'Assistant Coach', 'YMCA', 'Karen', 'Manson', '444-444-4444', '07/21/2019', '09/27/2022', 100010);

INSERT INTO Employee VALUES (111111, 32.75, 'XL', 'Advising basketball employees', 'Limited', 'Advisor');
INSERT INTO Employee VALUES (111112, 27.50, 'L', 'Advising yoga employees', 'Limited', 'Advisor'); 
INSERT INTO Employee VALUES (111113, 30.00, 'L', 'Coaching the volleyball team', 'None', 'Coach');
INSERT INTO Employee VALUES (111114, 25.75, 'XXL', 'Helping monitor the swimming program', 'Full', 'Assistant Director');
INSERT INTO Employee VALUES (111115, 30.00, 'L', 'Managing the gym daily', 'Full', 'Manager');
INSERT INTO Employee VALUES (111116, 32.00, 'XL', 'Enforcing rules at football games', 'None', 'Referee');
INSERT INTO Employee VALUES (111117, 34.50, 'XL', 'Helping manage the soccer program', 'Full', 'Assistant Manager');
INSERT INTO Employee VALUES (111118, 35.25, 'XXL', 'Training crossfit program', 'Limited', 'Trainer');
INSERT INTO Employee VALUES (111119, 28.00, 'L', 'Coaching the baseball team', 'None', 'Coach');
INSERT INTO Employee VALUES (111120, 30.00, 'L', 'Teaching people how to play softball', 'Limited', 'Instructor');

INSERT INTO PayRaise VALUES (222221, 75.00, '03/20/2023', 'Outstanding performance', 111111);
INSERT INTO PayRaise VALUES (222222, 80.00, '03/21/2023', 'Outstanding performance', 111112);
INSERT INTO PayRaise VALUES (222223, 50.75, '03/22/2023', 'Outstanding performance', 111113);
INSERT INTO PayRaise VALUES (222224, 60.50, '03/23/2023', 'Outstanding performance', 111114);
INSERT INTO PayRaise VALUES (222225, 25.25, '03/24/2023', 'Outstanding performance', 111115);
INSERT INTO PayRaise VALUES (222226, 30.50, '03/25/2023', 'Outstanding performance', 111116);
INSERT INTO PayRaise VALUES (222227, 50.50, '03/26/2023', 'Outstanding performance', 111117);
INSERT INTO PayRaise VALUES (222228, 60.00, '03/27/2023', 'Outstanding performance', 111118);
INSERT INTO PayRaise VALUES (222229, 70.00, '03/28/2023', 'Outstanding performance', 111119);
INSERT INTO PayRaise VALUES (222230, 55.00, '03/29/2023', 'Outstanding performance', 111120);

INSERT INTO Program VALUES (333331, 'Basketball', 'Teams score points by throwing ball in a hoop');
INSERT INTO Program VALUES (333332, 'Yoga', 'Physical, mental, and spiritual practices');
INSERT INTO Program VALUES (333333, 'Volleyball', 'Teams score points by hitting ball to ground on other side of net');
INSERT INTO Program VALUES (333334, 'Swimming', 'Using entire body to push across water');
INSERT INTO Program VALUES (333335, 'Weightlifting', 'The sport of lifting barbells or other heavy weights');
INSERT INTO Program VALUES (333336, 'Football', 'Sport where 2 teams try to advance ball into other end zone');
INSERT INTO Program VALUES (333337, 'Soccer', 'Teams have to score goals by kicking ball into goal');
INSERT INTO Program VALUES (333338, 'Crossfit', 'A high-intensity fitness program');
INSERT INTO Program VALUES (333339, 'Baseball', 'Male sport and teams hit ball with bat and score by running around bases');
INSERT INTO Program VALUES (333340, 'Softball', 'Female sport and teams hit ball with bat and score by running around bases');

INSERT INTO JobRole VALUES (444441, 'Advising basketball employees', 111111, 333331);
INSERT INTO JobRole VALUES (444442, 'Advising yoga employees', 111112, 333332);
INSERT INTO JobRole VALUES (444443, 'Coaching the volleyball team', 111113, 333333);
INSERT INTO JobRole VALUES (444444, 'Helping monitor the swimming program', 111114, 333334);
INSERT INTO JobRole VALUES (444445, 'Managing the gym daily', 111115, 333335);
INSERT INTO JobRole VALUES (444446, 'Enforcing rules at football games', 111116, 333336);
INSERT INTO JobRole VALUES (444447, 'Helping manage the soccer program', 111117, 333337);
INSERT INTO JobRole VALUES (444448, 'Training crossfit program', 111118, 333338);
INSERT INTO JobRole VALUES (444449, 'Coaching the baseball team', 111119, 333339);
INSERT INTO JobRole VALUES (444450, 'Teaching people how to play softball', 111120, 333340);

INSERT INTO CampusInvolvement VALUES (555551, 'Reading Club', 111111);
INSERT INTO CampusInvolvement VALUES (555552, 'Christian Club', 111112);
INSERT INTO CampusInvolvement VALUES (555553, 'Christian Club', 111113);
INSERT INTO CampusInvolvement VALUES (555554, 'Marketing Club', 111114);
INSERT INTO CampusInvolvement VALUES (555555, 'Finance Club', 111115);
INSERT INTO CampusInvolvement VALUES (555556, 'Accounting Club', 111116);
INSERT INTO CampusInvolvement VALUES (555557, 'Fitness Club', 111117);
INSERT INTO CampusInvolvement VALUES (555558, 'Art Club', 111118);
INSERT INTO CampusInvolvement VALUES (555559, 'Cooking Club', 111119);
INSERT INTO CampusInvolvement VALUES (555560, 'Marketing Club', 111120);

INSERT INTO PersonalTrainer VALUES (666661, 25.00, 32, 111111);
INSERT INTO PersonalTrainer VALUES (666662, 25.00, 34, 111112);
INSERT INTO PersonalTrainer VALUES (666663, 28.00, 40, 111113);
INSERT INTO PersonalTrainer VALUES (666664, 30.00, 31, 111114);
INSERT INTO PersonalTrainer VALUES (666665, 32.50, 36, 111115);
INSERT INTO PersonalTrainer VALUES (666666, 25.50, 35, 111116);
INSERT INTO PersonalTrainer VALUES (666667, 27.75, 40, 111117);
INSERT INTO PersonalTrainer VALUES (666668, 30.75, 37, 111118);
INSERT INTO PersonalTrainer VALUES (666669, 27.50, 35, 111119);
INSERT INTO PersonalTrainer VALUES (666670, 25.00, 35, 111120);

INSERT INTO ProgramParticipant VALUES (600001, 'JJ', 'Warren', '19 E. Kent St.', 'Huntley', 'IL', '60142', '179-366-1725', 'Male', '08/14/2002', '03/13/2023');
INSERT INTO ProgramParticipant VALUES (600002, 'AJ', 'Irving', '891 Augusta Court', 'Sugar Land', 'TX', '77478', '718-233-8480', 'Male', '09/16/2003', '02/28/2023');
INSERT INTO ProgramParticipant VALUES (600003, 'Tim', 'Harrison', '59 Ramblewood St.', 'Revere', 'MA', '02151', '137-273-7572', 'Male', '12/27/2002', '03/03/2023');
INSERT INTO ProgramParticipant VALUES (600004, 'Layla', 'Henderson', '5 Bowman Rd.', 'San Angelo', 'TX', '76901', '395-242-2258', 'Female', '03/09/2002', '03/09/2023');
INSERT INTO ProgramParticipant VALUES (600005, 'Patricia', 'Johnson', '8115 Buttonwood Drive', 'Englishtown', 'NJ', '07726', '186-111-1345', 'Female', '07/21/2003', '03/05/2023');
INSERT INTO ProgramParticipant VALUES (600006, 'Michael', 'Tatum', '72 Green Drive', 'Glendale', 'AZ', '85302', '822-146-2429', 'Male', '11/26/2003', '02/21/2023');
INSERT INTO ProgramParticipant VALUES (600007, 'Claire', 'James', '7597 Bradford Ave.', 'Waukegan', 'IL', '60085', '561-846-4676', 'Female', '04/01/2001', '03/26/2023');
INSERT INTO ProgramParticipant VALUES (600008, 'Brian', 'Smith', '46 Cemetery Street', 'Freeport', 'NY', '11520', '925-536-6787', 'Male', '06/19/2002', '02/25/2023');
INSERT INTO ProgramParticipant VALUES (600009, 'Matthew', 'Jordan', '12 William Street', 'Lake Charles', 'LA', '70605', '255-555-2513', 'Male', '05/13/2002', '03/07/2023');
INSERT INTO ProgramParticipant VALUES (600010, 'Andrew', 'Ryan', '8116 Pheasant St.', 'Edison', 'NJ', '08817', '914-003-4250', 'Male', '06/12/2002', '03/20/2023');

INSERT INTO Appointment VALUES (666661, 600001, 30.00);
INSERT INTO Appointment VALUES (666662, 600002, 40.00);
INSERT INTO Appointment VALUES (666663, 600003, 50.00);
INSERT INTO Appointment VALUES (666664, 600004, 30.00);
INSERT INTO Appointment VALUES (666665, 600005, 35.00);
INSERT INTO Appointment VALUES (666666, 600006, 45.00);
INSERT INTO Appointment VALUES (666667, 600007, 25.00);
INSERT INTO Appointment VALUES (666668, 600008, 50.00);
INSERT INTO Appointment VALUES (666669, 600009, 45.00);
INSERT INTO Appointment VALUES (666670, 600010, 50.00);

INSERT INTO ProgramActivity VALUES (777771, '10/01/2022', '1/20/2023', 5.00, 333331);
INSERT INTO ProgramActivity VALUES (777772, '04/01/2023', NULL, NULL, 333332);
INSERT INTO ProgramActivity VALUES (777773, '03/25/2023', NULL, 5.00, 333333);
INSERT INTO ProgramActivity VALUES (777774, '12/10/2022', '03/01/2023', 5.00, 333334);
INSERT INTO ProgramActivity VALUES (777775, '01/05/2023', NULL, NULL, 333335);
INSERT INTO ProgramActivity VALUES (777776, '08/28/2022', '02/01/2023', 10.00, 333336);
INSERT INTO ProgramActivity VALUES (777777, '09/01/2022', '12/01/2022', NULL, 333337);
INSERT INTO ProgramActivity VALUES (777778, '01/05/2023', NULL, NULL, 333338);
INSERT INTO ProgramActivity VALUES (777779, '04/01/2023', NULL, 5.00, 333339);
INSERT INTO ProgramActivity VALUES (777780, '04/01/2023', NULL, 5.00, 333340);

INSERT INTO AssignedEmployee VALUES (111111, 777771);
INSERT INTO AssignedEmployee VALUES (111112, 777772);
INSERT INTO AssignedEmployee VALUES (111113, 777773);
INSERT INTO AssignedEmployee VALUES (111114, 777774);
INSERT INTO AssignedEmployee VALUES (111115, 777775);
INSERT INTO AssignedEmployee VALUES (111116, 777776);
INSERT INTO AssignedEmployee VALUES (111117, 777777);
INSERT INTO AssignedEmployee VALUES (111118, 777778);
INSERT INTO AssignedEmployee VALUES (111119, 777779);
INSERT INTO AssignedEmployee VALUES (111120, 777780);

INSERT INTO EmployeeProgram VALUES (111111, 333331, 35, NULL, 'Good progress');
INSERT INTO EmployeeProgram VALUES (111112, 333332, 30, NULL, NULL);
INSERT INTO EmployeeProgram VALUES (111113, 333333, 30, NULL, NULL);
INSERT INTO EmployeeProgram VALUES (111114, 333334, 35, NULL, 'Great progress');
INSERT INTO EmployeeProgram VALUES (111115, 333335, 34, NULL, 'Good progress');
INSERT INTO EmployeeProgram VALUES (111116, 333336, 33, NULL, 'Good progress');
INSERT INTO EmployeeProgram VALUES (111117, 333337, 40, NULL, NULL);
INSERT INTO EmployeeProgram VALUES (111118, 333338, 40, NULL, NULL);
INSERT INTO EmployeeProgram VALUES (111119, 333339, 40, NULL, NULL);
INSERT INTO EmployeeProgram VALUES (111120, 333340, 37, NULL, NULL);

INSERT INTO ActivityParticipant VALUES (600001, 777771, '08/12/2022', '08:30:03:00');
INSERT INTO ActivityParticipant VALUES (600002, 777772, '08/15/2022', '11:11:23:00');
INSERT INTO ActivityParticipant VALUES (600003, 777773, '08/02/2022', '14:53:12:00');
INSERT INTO ActivityParticipant VALUES (600004, 777774, '07/17/2022', '20:02:33:00');
INSERT INTO ActivityParticipant VALUES (600005, 777775, '06/23/2022', '09:07:11:00');
INSERT INTO ActivityParticipant VALUES (600006, 777776, '08/01/2022', '12:12:12:00');
INSERT INTO ActivityParticipant VALUES (600007, 777777, '07/14/2022', '13:55:52:00');
INSERT INTO ActivityParticipant VALUES (600008, 777778, '07/22/2022', '21:25:55:00');
INSERT INTO ActivityParticipant VALUES (600009, 777779, '06/18/2022', '17:21:32:00');
INSERT INTO ActivityParticipant VALUES (600010, 777780, '07/27/2022', '16:42:17:00');