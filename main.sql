CREATE TABLE meter (
    zone VARCHAR(50),
    area VARCHAR(50),
    sub_area VARCHAR(80),
    pole VARCHAR(20),
    config_id INT,
    config_name VARCHAR(200),
    date_inventory DATE,
    lat FLOAT,
    lng FLOAT,
    sapid VARCHAR(20)
);

CREATE TABLE incident (
	service_request_id INT NOT NULL PRIMARY KEY,
	service_request_parent_id INT,
    sap_notification_number FLOAT,
    date_requested DATE,
    case_age_days INT,
    case_record_type VARCHAR(10),
    service_name VARCHAR(100),
    service_name_detail VARCHAR(200),
    date_closed DATE,
    statuss VARCHAR(20),
    lat FLOAT,
    lng FLOAT,
    street_address VARCHAR(100),
    zipcode INT,
    council_district INT,
    comm_plan_code INT,
    comm_plan_name VARCHAR(50),
    park_name VARCHAR(50),
    case_origin VARCHAR(50),
    reffered VARCHAR(100),
    iamfloc VARCHAR(20),
    floc VARCHAR(20),
    public_description VARCHAR(500),
    file_year_split INT
);

CREATE TABLE cleared(
	service_request_id INT NOT NULL PRIMARY KEY,
	service_request_parent_id INT,
    sap_notification_number FLOAT,
    date_requested DATE,
    case_age_days INT,
    case_record_type VARCHAR(10),
    service_name VARCHAR(100),
    service_name_detail VARCHAR(200),
    date_closed DATE,
    statuss VARCHAR(20),
    lat FLOAT,
    lng FLOAT,
    street_address VARCHAR(100),
    zipcode INT,
    council_district INT,
    comm_plan_code INT,
    comm_plan_name VARCHAR(50),
    park_name VARCHAR(50),
    reffered VARCHAR(100),
    iamfloc VARCHAR(20),
    floc VARCHAR(20),
    public_description VARCHAR(500)
);

CREATE TABLE payment(
    pole_id VARCHAR(10),
    meter_type CHAR(2),
    date_trans_start DATE,
    date_meter_expire DATE,
    trans_amt INT,
    pay_method VARCHAR(20)
);

LOAD DATA LOCAL INFILE "D:/Projects/Parking_M/parking_meters.csv"
INTO TABLE meter
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;
ALTER TABLE meter
ADD COLUMN id INT AUTO_INCREMENT PRIMARY KEY;

LOAD DATA LOCAL INFILE "D:/Projects/Parking_M/incidents.csv"
INTO TABLE incident
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE "D:/Projects/Parking_M/cleared.csv"
INTO TABLE cleared
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE "D:/Projects/Parking_M/parking_payments.csv" 
INTO TABLE payment
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;
ALTER TABLE payment
ADD COLUMN id INT AUTO_INCREMENT PRIMARY KEY;


