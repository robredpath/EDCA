
/* CONTRATING PROCESS */
drop table if exists ContractingProcess cascade;
create table ContractingProcess (
	id serial primary key,
        Publisher_id int references Publisher(id),
	fecha_creacion date,
	hora_creacion time
	);

drop table if exists Publisher cascade;
create table Publisher (
	id serial primary key, 
        scheme varchar(30),
        name   text,
        uri    text
	);



/* ORGANIZATION TYPE */
drop table if exists OrganizationType cascade;
CREATE TABLE OrganizationType (
    id serial primary key,
    name character varying(50)
);

insert into organizationtype (name) values ('Buyer');
insert into organizationtype (name) values ('Tenderer');
insert into organizationtype (name) values ('Supplier');
insert into organizationtype (name) values ('Procuring Entity');


/* PLANNING */
drop table if exists Planning cascade;
create table Planning (
	id serial primary key, 
	ContractingProcess_id int references ContractingProcess(id) on delete cascade
	);

drop table if exists PlanningDocuments cascade;
create table PlanningDocuments (
	id serial primary key, 
	contractingprocess_id int references contractingprocess(id) on delete cascade,	
	planning_id int references planning(id) on delete cascade, 
	document_type text,
	title text, 
	description text, 
	url text, 
	date_published timestamp, 
	date_modified timestamp, 
	format text, 
	language text 
	);

drop table if exists Budget cascade;
create table Budget (
	id serial primary key, 
	contractingprocess_id int references contractingprocess(id) on delete cascade, 
	planning_id int references planning(id) on delete cascade, 
	budget_source text, 
	budget_description text, 
	budget_amount decimal, 
	budget_currency text, 
	budget_project text, 
	budget_projectID text, 
	budget_uri text, 
	rationale text 
	);

drop table if exists BudgetDocuments cascade;
create table BudgetDocuments (
	id serial primary key, 
	contractingprocess_id int references contractingprocess(id) on delete cascade, 
	budget_id int references budget(id) on delete cascade, 
	document_type text, 
	title text, 
	description text, 
	url text, 
	date_published timestamp, 
	date_modified timestamp, 
	format text, 
	language text 
	);

/* BUYER (organization) */
drop table if exists Buyer cascade;
create table Buyer (
	id serial primary key, 
	contractingprocess_id int references ContractingProcess(id) on delete cascade,
	name text,
	/*  no necesarios */
	/*identifier_scheme text, 
	identifier_legalname text, 
	identifier_uri text,  */
	address_streetaddres text, 
	address_locality text, 
	address_region text, 
	address_postalcode text, 
	address_contryname text,
	contactpoint_name text, 
	contactpoint_email text, 
	contactpoint_telephone text, 
	contactpoint_faxnumber text, 
	contactpoint_url text
	);

drop table if exists BuyerAdditionalIdentifiers cascade;
create table BuyerAdditionalIdentifiers(
	id serial primary key,
	contractingprocess_id int references ContractingProcess(id) on delete cascade,
	buyer_id int references buyer(id) on delete cascade,
	scheme text, 
	legalname text, 
	uri text
);

/* TENDER (licitación) */
drop table if exists Tender cascade;
create table Tender(
	id serial primary key,
	ContractingProcess_id int references ContractingProcess(id) on delete cascade,
	title text, 
	description text,
	status text,
	minvalue_amount decimal, 
	minvalue_currency text,
	value_amount decimal,
	value_currency text, 
	procurementmethod text,
	procurementmethod_rationale text,
	awardcriteria text, 
	awardcriteria_details text,
	submissionmethod text,
	submissionmethod_details text, 
	tenderperiod_startdate timestamp,
	tenderperiod_enddate timestamp,
	enquiryperiod_startdate timestamp, 
	enquiryperiod_enddate timestamp,
	hasenquiries int, 
	eligibilitycriteria text, 
	awardperiod_startdate timestamp,
	awardperiod_enddate timestamp,
	numberoftenderers int
	/*, 
	amendment_date timestamp,
	amendment_rationale text*/
	);

drop table if exists TenderDocuments cascade;
create table TenderDocuments (
	id serial primary key, 
	contractingprocess_id int references contractingprocess(id) on delete cascade, 
	tender_id int references Tender(id) on delete cascade, 
	document_type text, 
	title text, 
	description text, 
	url text, 
	date_published timestamp, 
	date_modified timestamp, 
	format text, 
	language text 
	);

/* Tenderer (Organization) */
drop table if exists Tenderer cascade;
create table Tenderer(
	id serial primary key,
	ContractingProcess_id int references ContractingProcess(id) on delete cascade,
	Tender_id int references Tender(id) on delete cascade,
	name text,
	/*identifier_scheme text, 
	identifier_legalname text, 
	identifier_uri text,  */
	address_streetaddres text, 
	address_locality text, 
	address_region text, 
	address_postalcode text, 
	address_contryname text,
	contactpoint_name text, 
	contactpoint_email text, 
	contactpoint_telephone text, 
	contactpoint_faxnumber text, 
	contactpoint_url text
	);

drop table if exists TendererAdditionalIdentifiers cascade;
create table TendererAdditionalIdentifiers(
	id serial primary key,
	contractingprocess_id int references ContractingProcess(id) on delete cascade,
	tenderer_id int references Tenderer(id) on delete cascade,
	scheme text, 
	legalname text, 
	uri text
);

/* ProcuringEntity (organization) */
drop table if exists ProcuringEntity cascade;
create table ProcuringEntity(
	id serial primary key, 
	ContractingProcess_id int references ContractingProcess(id) on delete cascade,
	Tender_id int references Tender(id) on delete cascade,
	name text,
	/*identifier_scheme text, 
	identifier_legalname text, 
	identifier_uri text,  */
	address_streetaddres text, 
	address_locality text, 
	address_region text, 
	address_postalcode text, 
	address_contryname text,
	contactpoint_name text, 
	contactpoint_email text, 
	contactpoint_telephone text, 
	contactpoint_faxnumber text, 
	contactpoint_url text
	);

drop table if exists ProcuringEntityAdditionalIdentifiers cascade;
create table ProcuringEntityAdditionalIdentifiers(
	id serial primary key,
	contractingprocess_id int references ContractingProcess(id) on delete cascade,
	prcuringentity_id int references ProcuringEntity(id) on delete cascade,
	scheme text, 
	legalname text, 
	uri text
);

drop table if exists TenderMilestone cascade;
create table TenderMilestone(
	id serial primary key,
	contractingprocess_id int references ContractingProcess(id) on delete cascade,
	tender_id int references Tender(id) on delete cascade,
	title text,
	description text,
	duedate timestamp, 
	date_modified timestamp,
	status text
);

drop table if exists TenderMilestoneDocuments cascade;
create table TenderMilestoneDocuments(
	id serial primary key, 
	contractingprocess_id int references contractingprocess(id) on delete cascade, 
	tender_id int references Tender(id) on delete cascade, 
	milestone_id int references TenderMilestone(id) on delete cascade,
	document_type text, 
	title text, 
	description text, 
	url text, 
	date_published timestamp, 
	date_modified timestamp, 
	format text, 
	language text 
);

drop table if exists TenderItem cascade;
create table TenderItem(
	id serial primary key,
	contractingprocess_id int references ContractingProcess(id) on delete cascade,
	description text,
	/*classification... */
	quantity int,
	unit_name text, 
	unit_value_amount decimal,
	unit_value_currency text
);

drop table if exists TenderItemAdditionalClassifications cascade;
create table TenderItemAdditionalClassifications(
	id serial primary key,
	contractingprocess_id int references ContractingProcess(id) on delete cascade,
	tenderitem_id int references TenderItem(id) on delete cascade,
	scheme text,
	description text,
	uri text
);

drop table if exists TenderAmendment cascade;
create table TenderAmendment(
	id serial primary key,
	contractingprocess_id int references ContractingProcess(id) on delete cascade,
	tender_id int references TenderItem(id) on delete cascade,
	amendment_date timestamp,
	rationale text
); 

drop table if exists TenderAmendmentChanges cascade;
create table TenderAmendmentChanges(
	id serial primary key, 
	contractingprocess_id int references ContractingProcess(id) on delete cascade, 
	tenderamendment_id int references TenderAmendment(id) on delete cascade,
	property text, 
	former_value text
);


/* AWARD (Adjudicación) */
drop table if exists Award cascade;
create table Award(
	id serial primary key,
	contractingprocess_id int references ContractingProcess(id) on delete cascade,
	title text,
	description text,
	status text,
	award_date timestamp,
	value_amount decimal,
	value_currency text,
	contractperiod_startdate timestamp,
	contractperiod_enddate timestamp
); /*remover -> amendment*/

drop table if exists AwardDocument cascade;
create table AwardDocument(
	id serial primary key,
	contractingprocess_id int references ContractingProcess(id) on delete cascade,
	award_id int references Award(id), 
	document_type text, 
	title text, 
	description text, 
	url text, 
	date_published timestamp, 
	date_modified timestamp, 
	format text, 
	language text 
);


/* Supplier (Organization) */
drop table if exists Supplier cascade;
create table Supplier(
	id serial primary key,
	contractingprocess_id int references ContractingProcess(id) on delete cascade, 
	award_id int references Award(id),
	name text,
	/*identifier_scheme text, 
	identifier_legalname text, 
	identifier_uri text,  */
	address_streetaddres text, 
	address_locality text, 
	address_region text, 
	address_postalcode text, 
	address_contryname text,
	contactpoint_name text, 
	contactpoint_email text, 
	contactpoint_telephone text, 
	contactpoint_faxnumber text, 
	contactpoint_url text
);


drop table if exists SupplierAdditionalIdentifiers cascade;
create table SupplierAdditionalIdentifiers(
	id serial primary key, 
	contractingprocess int references ContractingProcess(id) on delete cascade,
	award_id int references Award(id) on delete cascade, 
	supplier_id int references Supplier(id) on delete cascade,
	scheme text, 
	legalname text, 
	uri text
);

drop table if exists AwardAmendment cascade;
create table AwardAmendment(
	id serial primary key,
	contractingprocess_id int references ContractingProcess(id) on delete cascade,
	award_id int references Award(id) on delete cascade,
	amendment_date timestamp,
	rationale text
);

drop table if exists AwardAmendmentChanges cascade;
create table AwardAmendmentChanges(
	id serial primary key, 
	contractingprocess_id int references ContractingProcess(id) on delete cascade,
	award_id int references AwardAmendment(id) on delete cascade, 
	awardamendment_id int references AwardAmendment(id) on delete cascade,
	property text,
	former_value text
);

drop table if exists AwardItem cascade;
create table AwardItem(
	id serial primary key, 
	award_id int references Award(id) on delete cascade,
	description text,
	/*classification... */
	quantity int,
	unit_name text, 
	unit_value_amount decimal,
	unit_value_currency text
);

drop table if exists AwardItemAdditionalClassifications cascade;
create table AwardItemAdditionalClassifications(
	id serial primary key,
	award_id int references Award(id) on delete cascade,
	awarditem_id int references AwardItem(id) on delete cascade,
	scheme text,
	description text,
	uri text	
);


/* CONTRACT (Contratación) */
drop table if exists Contract cascade;
create table Contract(
	id serial primary key,
	contractingprocess_id int references ContractingProcess(id) on delete cascade,
	title text,
	description text,
	status text, 
	period_startdate timestamp,
	period_enddate timestamp,
	value_amount decimal, 
	value_currency text,
	datesigned timestamp
	/* amendment ...*/
);

drop table if exists ContractDocuments cascade;
create table ContractDocuments(
	id serial primary key,
	contractingprocess_id int references ContractingProcess(id) on delete cascade,  
	contract_id int references Contract(id) on delete cascade,
	document_type text, 
	title text, 
	description text, 
	url text, 
	date_published timestamp, 
	date_modified timestamp, 
	format text, 
	language text 
); 

drop table if exists ContractItem cascade;
create table ContractItem(
	id serial primary key,
	contractingprocess_id int references ContractingProcess(id) on delete cascade, 
	contract_id int references Contract(id) on delete cascade,
	description text,
	/*classification... */
	quantity int,
	unit_name text, 
	unit_value_amount decimal,
	unit_value_currency text

);

drop table if exists ContractItemAdditionalClasifications cascade;
create table ContractItemAdditionalClasifications(
	id serial primary key,
	contractingprocess_id int references ContractingProcess(id) on delete cascade, 
	contract_id int references Contract(id) on delete cascade,
	contractitem_id int references ContractItem(id) on delete cascade,
	scheme text,
	description text,
	uri text
);

drop table if exists ContractAmendment cascade;
create table ContractAmendment(
	id serial primary key,
	contractingprocess_id int references ContractingProcess(id) on delete cascade, 
	contract_id int references Contract(id) on delete cascade,
	amendment_date timestamp,
	rationale text
);

drop table if exists ContractAmendmentChanges cascade;
create table ContractAmendmentChanges(
	id serial primary key,
	contractingprocess_id int references ContractingProcess(id) on delete cascade, 
	contract_id int references Contract(id) on delete cascade,
	contractamendment_id int references ContractAmendment(id) on delete cascade,
	property text,
	former_value text
);

/* IMPLEMENTATION (Implementación)*/
drop table if exists Implementation cascade;
create table Implementation(
	id serial primary key,
	contractingprocess_id int references ContractingProcess(id) on delete cascade, 
	contract_id int references Contract(id) on delete cascade
);

drop table if exists ImplementationDocuments cascade;
create table ImplementationDocuments(
	id serial primary key,
	contractingprocess_id int references ContractingProcess(id) on delete cascade, 
	contract_id int references Contract(id) on delete cascade,
	implementation_id int references Implementation(id) on delete cascade,
	document_type text, 
	title text, 
	description text, 
	url text, 
	date_published timestamp, 
	date_modified timestamp, 
	format text, 
	language text 
);

drop table if exists ImplementationTransactions cascade;
create table ImplementationTransactions(
	id serial primary key,
	contractingprocess_id int references ContractingProcess(id) on delete cascade, 
	contract_id int references Contract(id) on delete cascade,
	implementation_id int references Implementation(id) on delete cascade,
	source text,
	implementation_date timestamp,
	value_amount decimal, 
	value_currency text,
	uri text
);
	
drop table if exists ProviderOrganization cascade;
create table ProviderOrganization(
	id serial primary key,
	contractingprocess_id int references ContractingProcess(id) on delete cascade, 
	contract_id int references Contract(id) on delete cascade,
	implementation_id int references Implementation(id) on delete cascade, 
	implementationtransaction_id int references ImplementationTransactions(id) on delete cascade,
	scheme text,
	legalname text,
	uri text
	);
	
drop table if exists ReceiverOrganization cascade;
create table ReceiverOrganization(
	id serial primary key,
	contractingprocess_id int references ContractingProcess(id) on delete cascade, 
	contract_id int references Contract(id) on delete cascade,
	implementation_id int references Implementation(id) on delete cascade, 
	implementationtransaction_id int references Implementation(id) on delete cascade,
	scheme text,
	legalname text,
	uri text
	);

drop table if exists ImplementationMilestones cascade;
create table ImplementationMilestones(
	id serial primary key,
	contractingprocess_id int references ContractingProcess(id) on delete cascade, 
	contract_id int references Contract(id) on delete cascade,
	implementation_id int references Implementation(id) on delete cascade, 
	title text,
	description text,
	duedate timestamp, 
	date_modified timestamp,
	status text
);

drop table if exists ImplementationMilestoneDocuments cascade;
create table ImplementationMilestoneDocuments(
	id serial primary key,
	contractingprocess_id int references ContractingProcess(id) on delete cascade, 
	contract_id int references Contract(id) on delete cascade,
	implementation_id int references Implementation(id) on delete cascade,
	document_type text, 
	title text, 
	description text, 
	url text, 
	date_published timestamp, 
	date_modified timestamp, 
	format text, 
	language text 
);

