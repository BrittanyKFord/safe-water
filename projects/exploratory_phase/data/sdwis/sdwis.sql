/*
 * WATER SYSTEM Table
 */

create table WATER_SYSTEM
(
	PWSID VARCHAR(9) not null,
	PWS_NAME TEXT null,
	NPM_CANDIDATE BOOLEAN null,
	PRIMACY_AGENCY_CODE TEXT null,
	EPA_REGION INT null,
	SEASON_BEGIN_DATE TEXT null,
	SEASON_END_DATE TEXT null,
	PWS_ACTIVITY_CODE TEXT null,
	PWS_DEACTIVATION_DATE DATE null,
	PWS_TYPE_CODE TEXT null,
	DBPR_SCHEDULE_CAT_CODE TEXT null,
	CDS_ID TEXT null,
	GW_SW_CODE TEXT null,
	LT2_SCHEDULE_CAT_CODE TEXT null,
	OWNER_TYPE_CODE TEXT null,
	POPULATION_SERVED_COUNT INT null,
	POP_CAT_2_CODE INT null,
	POP_CAT_3_CODE INT null,
	POP_CAT_4_CODE INT null,
	POP_CAT_5_CODE INT null,
	POP_CAT_11_CODE INT null,
	PRIMACY_TYPE TEXT null,
	PRIMARY_SOURCE_CODE TEXT null,
	IS_GRANT_ELIGIBLE_IND BOOLEAN null,
	IS_WHOLESALER_IND BOOLEAN null,
	IS_SCHOOL_OR_DAYCARE_IND BOOLEAN null,
	SERVICE_CONNECTIONS_COUNT INT null,
	SUBMISSION_STATUS_CODE TEXT null,
	ORG_NAME TEXT null,
	ADMIN_NAME TEXT null,
	EMAIL_ADDR TEXT null,
	PHONE_NUMBER TEXT null,
	PHONE_EXT_NUMBER TEXT null,
	FAX_NUMBER TEXT null,
	ALT_PHONE_NUMBER TEXT null,
	ADDRESS_LINE1 TEXT null,
	ADDRESS_LINE2 TEXT null,
	CITY_NAME TEXT null,
	ZIP_CODE TEXT null,
	COUNTRY_CODE TEXT null,
	STATE_CODE TEXT null,
	SOURCE_WATER_PROTECTION_CODE TEXT null,
	SOURCE_PROTECTION_BEGIN_DATE TEXT null,
	OUTSTANDING_PERFORMER TEXT null,
	OUTSTANDING_PERFORM_BEGIN_DATE TEXT null,
	CITIES_SERVED TEXT null,
	COUNTIES_SERVED TEXT null
);

create unique index WATER_SYSTEM_PWSID_uindex
	on WATER_SYSTEM (PWSID);

alter table WATER_SYSTEM
	add constraint WATER_SYSTEM_pk
		primary key (PWSID);

/*
 * WATER SYSTEM FACILITY Table
 */

	create table WATER_SYSTEM_FACILITY
(
	PWSID VARCHAR(9) null,
	ID VARCHAR(36) not null,
	PRIMACY_AGENCY_CODE TEXT null,
	EPA_REGION INT null,
	FACILITY_ID VARCHAR(12) null,
	FACILITY_NAME TEXT null,
	STATE_FACILITY_ID TEXT null,
	FACILITY_ACTIVITY_CODE TEXT null,
	FACILITY_DEACTIVATION_DATE DATE null,
	FACILITY_TYPE_CODE TEXT null,
	SUBMISSION_STATUS_CODE TEXT null,
	IS_SOURCE_IND BOOLEAN null,
	WATER_TYPE_CODE TEXT null,
	AVAILABILITY_CODE TEXT null,
	SELLER_TREATMENT_CODE TEXT null,
	SELLER_PWSID VARCHAR(9) null,
	SELLER_PWS_NAME TEXT null,
	FILTRATION_STATUS_CODE TEXT null,
	PWS_ACTIVITY_CODE TEXT null,
	PWS_DEACTIVATION_DATE DATE null,
	PWS_TYPE_CODE TEXT null,
	IS_SOURCE_TREATED_IND TEXT null
);

create unique index WATER_SYSTEM_FACILITY_FACILITY_ID_uindex
	on WATER_SYSTEM_FACILITY (ID);

alter table WATER_SYSTEM_FACILITY
	add constraint WATER_SYSTEM_FACILITY_pk
		primary key (ID);

/* Once the table is created, use the mysql LOAD DATA utility to push the data on the server.

LOAD DATA
LOCAL
INFILE '/Users/fpaupier/projects/safe-water/data/SDWIS/sanitized/WATER_SYSTEM_FACILITY.csv'
INTO TABLE WATER_SYSTEM_FACILITY
FIELDS
	TERMINATED BY ','
LINES
	TERMINATED BY '\n';

*/


/*
 * VIOLATION Table
 */


create table VIOLATION
(
	PWSID TEXT null,
	ID VARCHAR(36) not null,
	VIOLATION_ID VARCHAR(20) not null,
	FACILITY_ID VARCHAR(12) null,
	POPULATION_SERVED_COUNT INT null,
	NPM_CANDIDATE TEXT null,
	PWS_ACTIVITY_CODE TEXT null,
	PWS_DEACTIVATION_DATE TEXT null,
	PRIMARY_SOURCE_CODE TEXT null,
	POP_CAT_5_CODE INT null,
	PRIMACY_AGENCY_CODE TEXT null,
	EPA_REGION INT null,
	PWS_TYPE_CODE TEXT null,
	VIOLATION_CODE VARCHAR(2) null,
	VIOLATION_CATEGORY_CODE TEXT null,
	IS_HEALTH_BASED_IND TEXT null,
	CONTAMINANT_CODE INT null,
	COMPLIANCE_STATUS_CODE TEXT null,
	VIOL_MEASURE TEXT null,
	UNIT_OF_MEASURE TEXT null,
	STATE_MCL TEXT null,
	IS_MAJOR_VIOL_IND TEXT null,
	SEVERITY_IND_CNT TEXT null,
	COMPL_PER_BEGIN_DATE DATE null,
	COMPL_PER_END_DATE DATE null,
	LATEST_ENFORCEMENT_ID TEXT null,
	RTC_ENFORCEMENT_ID TEXT null,
	RTC_DATE DATE null,
	PUBLIC_NOTIFICATION_TIER INT null,
	ORIGINATOR_CODE TEXT null,
	SAMPLE_RESULT_ID TEXT null,
	CORRECTIVE_ACTION_ID TEXT null,
	RULE_CODE VARCHAR(3) null,
	RULE_GROUP_CODE VARCHAR(3) null,
	RULE_FAMILY_CODE VARCHAR(3) null
);

create index VIOLATION_ID_INDEX
	on VIOLATION (VIOLATION_ID);

create unique index VIOLATION_ID_uindex
	on VIOLATION (ID);

alter table VIOLATION
	add constraint VIOLATION_pk
		primary key (ID);



/*
 * VIOLATION_ENF_ASSOC Table
 */

create table VIOLATION_ENF_ASSOC
(
	PWSID VARCHAR(9) not null,
	ID VARCHAR(36) not null,
	ENFORCEMENT_ID INT not null,
	VIOLATION_ID VARCHAR(20) not null,
	constraint VIOLATION_ENF_ASSOC___fk_ENF
		foreign key (ENFORCEMENT_ID) references ENFORCEMENT_ACTION (ENFORCEMENT_ID),
	constraint VIOLATION_ENF_ASSOC___fk_PWSID
		foreign key (PWSID) references WATER_SYSTEM (PWSID),
	constraint VIOLATION_ENF_ASSOC___fk_VIOLATION
		foreign key (VIOLATION_ID) references VIOLATION (VIOLATION_ID)
);

create unique index VIOLATION_ENF_ASSOC_ID_uindex
	on VIOLATION_ENF_ASSOC (ID);

alter table VIOLATION_ENF_ASSOC
	add constraint VIOLATION_ENF_ASSOC_pk
		primary key (ID);


 /*
 * SERVICE AREA Table
 */


create table SERVICE_AREA
(
	PWSID VARCHAR(9) not null,
	ID VARCHAR(36) not null,
	PRIMACY_AGENCY_CODE TEXT null,
	EPA_REGION INT null,
	PWS_ACTIVITY_CODE TEXT null,
	PWS_TYPE_CODE TEXT null,
	SERVICE_AREA_TYPE_CODE TEXT null,
	IS_PRIMARY_SERVICE_AREA_CODE TEXT null,
	constraint SERVICE_AREA_WATER_SYSTEM_PWSID_fk
		foreign key (PWSID) references WATER_SYSTEM (PWSID)
);

create unique index SERVICE_AREA_ID_uindex
	on SERVICE_AREA (ID);

alter table SERVICE_AREA
	add constraint SERVICE_AREA_pk
		primary key (ID);

/*
 * Geographic Area table
 */

 create table GEOGRAPHIC_AREA
(
	PWSID VARCHAR(9) not null,
	GEO_ID INT not null,
	PRIMACY_AGENCY_CODE TEXT null,
	EPA_REGION INT null,
	PWS_ACTIVITY_CODE TEXT null,
	PWS_TYPE_CODE TEXT null,
	TRIBAL_CODE TEXT null,
	STATE_SERVED TEXT null,
	ANSI_ENTITY_CODE TEXT null,
	ZIP_CODE_SERVED TEXT null,
	CITY_SERVED TEXT null,
	AREA_TYPE_CODE TEXT null,
	COUNTY_SERVED TEXT null,
	constraint DG_GEOGRAPHIC_AREA_WATER_SYSTEM_PWSID_fk
		foreign key (PWSID) references WATER_SYSTEM (PWSID)
);

create unique index DG_GEOGRAPHIC_AREA_GEO_ID_uindex
	on DG_GEOGRAPHIC_AREA (GEO_ID);

alter table GEOGRAPHIC_AREA
	add constraint DG_GEOGRAPHIC_AREA_pk
		primary key (GEO_ID);

/*
* ENFORCEMENT_ACTION table
*/

create table ENFORCEMENT_ACTION
(
	PWSID VARCHAR(9) null,
	ID VARCHAR(36) not null,
	ENFORCEMENT_ID INT not null,
	ORIGINATOR_CODE VARCHAR(1) null,
	ENFORCEMENT_DATE DATE null,
	ENFORCEMENT_ACTION_TYPE_CODE VARCHAR(3) null,
	ENFORCEMENT_COMMENT_TEXT TEXT null,
	constraint ENFORCEMENT_ACTION_WATER_SYSTEM_PWSID_fk
		foreign key (PWSID) references WATER_SYSTEM (PWSID)
);

create index ENFORCEMENT_ACTION_ENFO_ID
	on ENFORCEMENT_ACTION (ENFORCEMENT_ID);

create unique index ENFORCEMENT_ACTION_ID_uindex
	on ENFORCEMENT_ACTION (ID);

alter table ENFORCEMENT_ACTION
	add constraint ENFORCEMENT_ACTION_pk
		primary key (ID);


/*
 * CONTAMINANT_CODES Table
*/

create table CONTAMINANT_CODES
(
	CODE VARCHAR(4) not null,
	NAME TEXT null,
	SCIENTIFIC_NAME TEXT null,
	TYPE_CODE VARCHAR(3) null
);

create unique index CONTAMINANT_CODES_CODE_uindex
	on CONTAMINANT_CODES (CODE);

alter table CONTAMINANT_CODES
	add constraint CONTAMINANT_CODES
		primary key (CODE);

/*
 * CONTAMINANT_GROUP_CODES Table
 */

create table CONTAMINANT_GROUP_CODES
(
	CONTAMINANT_CODE VARCHAR(4) not null,
	ID VARCHAR(36) not null,
	CONTAMINANT_NAME TEXT null,
	CONTAMINANT_GROUP TEXT null,
	CONTAMINANT_GROUP_CODE VARCHAR(4) not null
);

create unique index CONTAMINANT_GROUP_CODES_ID_uindex
	on CONTAMINANT_GROUP_CODES (ID);

alter table CONTAMINANT_GROUP_CODES
	add constraint CONTAMINANT_GROUP_CODES_pk
		primary key (ID);

/*
* LCR_SAMPLE Table
*/

create table LCR_SAMPLE
			(
			SAMPLE_ID TEXT not null,
			ID VARCHAR(36) not null,
			PWSID VARCHAR(9) not null,
			SAMPLING_END_DATE DATE null,
			SAMPLING_START_DATE DATE null,
			PRIMACY_AGENCY_CODE VARCHAR(2) null,
			EPA_REGION INT null,
			constraint LCR_SAMPLE_WATER_SYSTEM_PWSID_fk
			foreign key (PWSID) references WATER_SYSTEM (PWSID)
			);
create unique index LCR_SAMPLE_ID_uindex
			on LCR_SAMPLE (ID);

alter table LCR_SAMPLE
			add constraint LCR_SAMPLE_pk
			primary key (ID);


/*
* LCR_SAMPLE_RESULT Table
*/

create table DG_LCR_SAMPLE_RESULT
(
	PWSID VARCHAR(9) not null,
	SAMPLE_ID TEXT not null,
	PRIMACY_AGENCY_CODE VARCHAR(2) not null,
	EPA_REGION INT not null,
	SAR_ID INT not null,
	CONTAMINANT_CODE VARCHAR(4) not null,
	RESULT_SIGN_CODE VARCHAR(1) null,
	SAMPLE_MEASURE FLOAT null,
	UNIT_OF_MEASURE TEXT null,
	constraint DG_LCR_SAMPLE_RESULT_WATER_SYSTEM_PWSID_fk
		foreign key (PWSID) references WATER_SYSTEM (PWSID)
);

create unique index DG_LCR_SAMPLE_RESULT_SAR_ID_uindex
	on DG_LCR_SAMPLE_RESULT (SAR_ID);

alter table DG_LCR_SAMPLE_RESULT
	add constraint DG_LCR_SAMPLE_RESULT_pk
		primary key (SAR_ID);



/*
* TREATMENT table
*/

create table TREATMENT
(
	TREATMENT_ID VARCHAR(17) not null,
	ID VARCHAR(36) not null,
	PWSID VARCHAR(9) not null,
	FACILITY_ID VARCHAR(12) not null,
	COMMENTS_TEXT TEXT null,
	TREATMENT_OBJECTIVE_CODE VARCHAR(1) not null,
	TREATMENT_PROCESS_CODE INT not null,
	constraint TREATMENT_WATER_SYSTEM_FACILITY_FACILITY_ID_fk
		foreign key (FACILITY_ID) references WATER_SYSTEM_FACILITY (FACILITY_ID),
	constraint TREATMENT_WATER_SYSTEM_PWSID_fk
		foreign key (PWSID) references WATER_SYSTEM (PWSID)
);

create unique index TREATMENT_ID_uindex
	on TREATMENT (ID);

alter table TREATMENT
	add constraint TREATMENT_pk
		primary key (ID);

