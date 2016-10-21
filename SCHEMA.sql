-- REMOVE OLD TABLES
-- m:m
DROP TABLE IF EXISTS udm_decisionspace_user;
DROP TABLE IF EXISTS udm_vis_user;
DROP TABLE IF EXISTS udm_visctrl_user;
DROP TABLE IF EXISTS udm_vis_decisionspace;
-- simple tables
DROP TABLE IF EXISTS udm_visualization;
DROP TABLE IF EXISTS udm_visctrl;
DROP TABLE IF EXISTS udm_decisionspace;
DROP TABLE IF EXISTS udm_user;

-- CREATE NEW SCHEMA
CREATE TABLE udm_user (
  id SERIAL   PRIMARY KEY,
  username    varchar (50)  NOT NULL,
  firstname   varchar (50)  NOT NULL,
  lastname    varchar (50)  NOT NULL,
  email       varchar (50)  NOT NULL,
  password    char    (128) NOT NULL,
  roles       varchar (50)  NOT NULL,
  deleted     boolean       NOT NULL DEFAULT FALSE
);
CREATE TABLE udm_decisionspace (
  id SERIAL   PRIMARY KEY,
  name        varchar (50)  NOT NULL,
  description varchar (50)
);
CREATE TABLE udm_visctrl (
  id SERIAL   PRIMARY KEY,
  name        varchar (50)   NOT NULL,
  url         varchar (128)  NOT NULL
);
CREATE TABLE udm_visualization (
  id SERIAL   PRIMARY KEY,
  name        varchar (50)   NOT NULL,
  url         varchar (128)  NOT NULL
);

-- m:m
CREATE TABLE udm_decisionspace_user (
  user_id           integer  REFERENCES udm_user (id) NOT NULL,
  decisionspace_id  integer  REFERENCES udm_decisionspace (id) NOT NULL,
  PRIMARY KEY(user_id, decisionspace_id)
);

CREATE TABLE udm_vis_user (
  user_id           integer  REFERENCES udm_user (id) NOT NULL,
  visualization_id  integer  REFERENCES udm_visualization (id) NOT NULL,
  PRIMARY KEY(user_id, visualization_id)
);

CREATE TABLE udm_visctrl_user (
  user_id           integer  REFERENCES udm_user (id) NOT NULL,
  visctrl_id        integer  REFERENCES udm_visctrl (id) NOT NULL,
  PRIMARY KEY(user_id, visctrl_id)
);

CREATE TABLE udm_vis_decisionspace (
  decisionspace_id  integer  REFERENCES udm_decisionspace (id) NOT NULL,
  visualization_id  integer  REFERENCES udm_visualization (id) NOT NULL,
  PRIMARY KEY(decisionspace_id, visualization_id)
);
