
/* CONTRATING PROCESS */
create table ContractingProcess (
	id serial primary key, 
	fecha_creacion date, 
	hora_creacion time
	);


/* ORGANIZATION TYPE */
CREATE TABLE organizationtype (
    id integer NOT NULL,
    name character varying(50)
);

insert into organizationtype (name) values ('Buyer');
insert into organizationtype (name) values ('Tenderer');
insert into organizationtype (name) values ('Supplier');
insert into organizationtype (name) values ('Procuring Entity');


/* PLANNING */
create table Planning (
	id serial primary key, 
	ContractingProcess_id int references ContractingProcess(id)
	);

create table budget (
	id serial primary key, 
	contractingprocess_id int references contractingprocess(id), 
	planning_id int references planning(id), budget_source text, 
	budget_description text, budget_amount decimal, 
	budget_currency text, budget_project text, 
	budget_projectID text, budget_uri text, rationale text 
	);

create table PlanningDocument (
	id serial primary key, 
	contractingprocess_id int references contractingprocess(id),
	planning_id int references planning(id), 
	document_type text, title text, 
	description text, url text, 
	date_published timestamp, 
	date_modified timestamp, 
	format text, language text 
	);

create table BudgetDocument (
	id serial primary key, 
	contractingprocess_id int references contractingprocess(id), 
	budget_id int references budget(id), 
	document_type text, title text, 
	description text, url text, 
	date_published timestamp, 
	date_modified timestamp, 
	format text, 
	language text 
	);


/* BUYER */
create table buyer (
	id serial primary key, 
	contractingprocess_id int references ContractingProcess(id),
	identifier_scheme text, 
	identifier_legalname text, 
	identifier_uri text, name text, 
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
