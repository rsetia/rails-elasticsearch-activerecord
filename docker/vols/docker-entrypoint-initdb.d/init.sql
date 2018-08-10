CREATE DATABASE IF NOT EXISTS main CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

use main; 

CREATE TABLE IF NOT EXISTS organizations (
  id int NOT NULL AUTO_INCREMENT,
  url text,
  external_id varchar(64),
  name varchar(64),
  created_at TIMESTAMP,
  details text,
  shared_tickets boolean, 
  PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS domain_names (
  id int NOT NULL AUTO_INCREMENT,
  organization_id int NOT NULL,
  value text,
  PRIMARY KEY (id),
  FOREIGN KEY (organization_id) REFERENCES organizations(id)
);

CREATE TABLE IF NOT EXISTS organization_tags (
  id int NOT NULL AUTO_INCREMENT,
  organization_id int NOT NULL,
  value text,
  PRIMARY KEY (id),
  FOREIGN KEY (organization_id) REFERENCES organizations(id)
);


CREATE TABLE IF NOT EXISTS users (
  id int NOT NULL AUTO_INCREMENT,
  url text,
  external_id varchar(64),
  name varchar(128),
  alias varchar(128),
  created_at TIMESTAMP,
  active boolean,
  verified boolean,
  shared boolean,
  locale varchar(64),
  timezone varchar(64),
  last_login_at TIMESTAMP NULL, 
  email varchar(320),
  phone varchar(64),
  signature text,
  organization_id int, 
  suspended boolean, 
  role varchar(16),
  PRIMARY KEY (id),
  FOREIGN KEY (organization_id) REFERENCES organizations(id)
);

CREATE TABLE IF NOT EXISTS user_tags (
  id int NOT NULL AUTO_INCREMENT,
  user_id int NOT NULL,
  value text,
  PRIMARY KEY (id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);


CREATE TABLE IF NOT EXISTS tickets (
  id varchar(36) NOT NULL,
  url text,
  external_id varchar(64),
  created_at TIMESTAMP,
  ticket_type varchar(128),
  subject varchar(256),
  description text,
  priority varchar(32),
  status varchar(32),
  submitter_id int, 
  assignee_id int, 
  organization_id int, 
  has_incidents boolean, 
  due_at TIMESTAMP NULL, 
  via varchar(128),
  PRIMARY KEY (id),
  FOREIGN KEY (organization_id) REFERENCES organizations(id),
  FOREIGN KEY (submitter_id) REFERENCES users(id),
  FOREIGN KEY (assignee_id) REFERENCES users(id)
);

CREATE TABLE IF NOT EXISTS ticket_tags (
  id int NOT NULL AUTO_INCREMENT,
  ticket_id varchar(36) NOT NULL,
  value text,
  PRIMARY KEY (id),
  FOREIGN KEY (ticket_id) REFERENCES tickets(id)
);
