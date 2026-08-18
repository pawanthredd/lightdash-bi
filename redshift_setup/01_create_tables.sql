-- ============================================================================
-- POC schema for Redshift Serverless
-- Run this once to create the schema and tables before loading the CSVs.
-- ============================================================================

CREATE SCHEMA IF NOT EXISTS landing_db;
SET search_path TO landing_db;

-- ----------------------------------------------------------------------------
-- 1. bin_sponsors  (dimension, tiny)
-- ----------------------------------------------------------------------------
DROP TABLE IF EXISTS bin_sponsors CASCADE;
CREATE TABLE bin_sponsors (
    bin_sponsor_id   VARCHAR(10)   NOT NULL,
    bin_sponsor_name VARCHAR(100)  NOT NULL,
    country_code     VARCHAR(2),
    region            VARCHAR(30),
    bin_range_start   INTEGER,
    bin_range_end     INTEGER,
    sponsor_tier      VARCHAR(10),
    onboarded_date    DATE,
    status            VARCHAR(20),
    risk_rating       VARCHAR(10),
    PRIMARY KEY (bin_sponsor_id)
)
DISTSTYLE ALL
SORTKEY (bin_sponsor_id);

-- ----------------------------------------------------------------------------
-- 2. program_managers  (dimension, small)
-- ----------------------------------------------------------------------------
DROP TABLE IF EXISTS program_managers CASCADE;
CREATE TABLE program_managers (
    program_manager_id   VARCHAR(10)  NOT NULL,
    program_manager_name VARCHAR(120),
    bin_sponsor_id        VARCHAR(10),
    industry_vertical     VARCHAR(50),
    country_code          VARCHAR(2),
    onboarded_date         DATE,
    status                 VARCHAR(20),
    fee_tier               VARCHAR(20),
    PRIMARY KEY (program_manager_id)
)
DISTSTYLE ALL
SORTKEY (program_manager_id);

-- ----------------------------------------------------------------------------
-- 3. products  (dimension, small)
-- ----------------------------------------------------------------------------
DROP TABLE IF EXISTS products CASCADE;
CREATE TABLE products (
    product_id          VARCHAR(12)  NOT NULL,
    product_name         VARCHAR(150),
    program_manager_id   VARCHAR(10),
    product_type         VARCHAR(30),
    card_network          VARCHAR(20),
    form_factor           VARCHAR(30),
    currency               VARCHAR(3),
    launch_date            DATE,
    status                 VARCHAR(20),
    target_segment         VARCHAR(20),
    PRIMARY KEY (product_id)
)
DISTSTYLE ALL
SORTKEY (product_id);

-- ----------------------------------------------------------------------------
-- 4. cards  (dimension-ish, medium volume)
-- ----------------------------------------------------------------------------
DROP TABLE IF EXISTS cards CASCADE;
CREATE TABLE cards (
    card_id           VARCHAR(15)  NOT NULL,
    product_id         VARCHAR(12),
    cardholder_ref      VARCHAR(20),
    card_type            VARCHAR(15),
    issue_date            DATE,
    activation_date       DATE,
    expiry_date           DATE,
    card_status           VARCHAR(15),
    PRIMARY KEY (card_id)
)
DISTSTYLE KEY
DISTKEY (card_id)
SORTKEY (issue_date);

-- ----------------------------------------------------------------------------
-- 5. authorisations  (fact, high volume)
-- ----------------------------------------------------------------------------
DROP TABLE IF EXISTS authorisations CASCADE;
CREATE TABLE authorisations (
    authorisation_id       VARCHAR(18)  NOT NULL,
    card_id                  VARCHAR(15),
    product_id                VARCHAR(12),
    authorisation_datetime     TIMESTAMP,
    merchant_id                 VARCHAR(20),
    merchant_name                 VARCHAR(100),
    mcc_code                        INTEGER,
    mcc_description                  VARCHAR(60),
    merchant_country                   VARCHAR(2),
    channel                              VARCHAR(15),
    pos_entry_mode                        VARCHAR(20),
    auth_amount                             DECIMAL(12,2),
    currency                                  VARCHAR(3),
    auth_response_code                          VARCHAR(4),
    auth_status                                   VARCHAR(15),
    decline_reason                                  VARCHAR(40),
    PRIMARY KEY (authorisation_id)
)
DISTSTYLE KEY
DISTKEY (card_id)
SORTKEY (authorisation_datetime);

-- ----------------------------------------------------------------------------
-- 6. transactions  (fact, high volume)
-- ----------------------------------------------------------------------------
DROP TABLE IF EXISTS transactions CASCADE;
CREATE TABLE transactions (
    transaction_id         VARCHAR(18)  NOT NULL,
    authorisation_id         VARCHAR(18),
    card_id                    VARCHAR(15),
    product_id                   VARCHAR(12),
    transaction_datetime           TIMESTAMP,
    settlement_date                  DATE,
    transaction_type                   VARCHAR(20),
    merchant_id                          VARCHAR(20),
    mcc_code                               INTEGER,
    transaction_amount                       DECIMAL(12,2),
    currency                                   VARCHAR(3),
    interchange_amount                           DECIMAL(12,4),
    scheme_fee_amount                              DECIMAL(12,4),
    processor_fee_amount                             DECIMAL(12,4),
    net_settlement_amount                              DECIMAL(12,2),
    transaction_status                                   VARCHAR(15),
    PRIMARY KEY (transaction_id)
)
DISTSTYLE KEY
DISTKEY (card_id)
SORTKEY (transaction_datetime);
