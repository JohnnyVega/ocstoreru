# OPENCART UPGRADE SCRIPT v1.5.x
# WWW.OPENCART.COM
# Qphoria

# THIS UPGRADE ONLY APPLIES TO PREVIOUS 1.5.x VERSIONS. DO NOT RUN THIS SCRIPT IF UPGRADING FROM v1.4.x 

# DO NOT RUN THIS ENTIRE FILE MANUALLY THROUGH PHPMYADMIN OR OTHER MYSQL DB TOOL
# THIS FILE IS GENERATED FOR USE WITH THE UPGRADE.PHP SCRIPT LOCATED IN THE INSTALL FOLDER
# THE UPGRADE.PHP SCRIPT IS DESIGNED TO VERIFY THE TABLES BEFORE EXECUTING WHICH PREVENTS ERRORS

# IF YOU NEED TO MANUALLY RUN THEN YOU CAN DO IT BY INDIVIDUAL VERSIONS. EACH SECTION IS LABELED.
# BE SURE YOU CHANGE THE PREFIX "oc_" TO YOUR PREFIX OR REMOVE IT IF NOT USING A PREFIX

# OCSTORE UPGRADE SCRIPT v1.0.x
#
# opencartforum.ru
# myopencart.ru

#### START UPGRADE OCSTORE 1.5.1.3

CREATE TABLE IF NOT EXISTS oc_manufacturer_description (
  manufacturer_id INT(11) NOT NULL,
  language_id INT(11) NOT NULL,
  description TEXT NOT NULL COLLATE utf8_general_ci,
  meta_description VARCHAR(255) NOT NULL COLLATE utf8_general_ci,
  meta_keyword VARCHAR(255) NOT NULL COLLATE utf8_general_ci,
  seo_title VARCHAR(255) NOT NULL COLLATE utf8_general_ci,
  seo_h1 VARCHAR(255) NOT NULL COLLATE utf8_general_ci,
  PRIMARY KEY (manufacturer_id, language_id)
) DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

CREATE TABLE IF NOT EXISTS oc_tax_rate_to_customer_group (
  tax_rate_id int(11) NOT NULL,
  customer_group_id int(11) NOT NULL,
  PRIMARY KEY (tax_rate_id, customer_group_id)
) DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

CREATE TABLE IF NOT EXISTS oc_tax_rule (
  tax_rule_id int(11) NOT NULL auto_increment,
  tax_class_id int(11) NOT NULL,
  tax_rate_id int(11) NOT NULL,
  based varchar(10) NOT NULL COLLATE utf8_general_ci,
  priority int(5) NOT NULL DEFAULT '1',
  PRIMARY KEY (tax_rule_id)
) DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

ALTER TABLE oc_category_description ADD seo_title VARCHAR(255) NOT NULL COLLATE utf8_general_ci AFTER meta_keyword;
ALTER TABLE oc_category_description ADD seo_h1 VARCHAR(255) NOT NULL COLLATE utf8_general_ci AFTER seo_title;

ALTER TABLE oc_customer ADD token varchar(255) NOT NULL COLLATE utf8_general_ci AFTER approved;

ALTER TABLE oc_information_description ADD meta_description VARCHAR(255) NOT NULL COLLATE utf8_general_ci AFTER description;
ALTER TABLE oc_information_description ADD meta_keyword VARCHAR(255) NOT NULL COLLATE utf8_general_ci AFTER meta_description;
ALTER TABLE oc_information_description ADD seo_title VARCHAR(255) NOT NULL COLLATE utf8_general_ci AFTER meta_keyword;
ALTER TABLE oc_information_description ADD seo_h1 VARCHAR(255) NOT NULL COLLATE utf8_general_ci AFTER seo_title;

ALTER TABLE oc_option_value ADD image varchar(255) NOT NULL COLLATE utf8_general_ci AFTER option_id;

ALTER TABLE oc_product_description ADD seo_title VARCHAR(255) NOT NULL COLLATE utf8_general_ci AFTER meta_keyword;
ALTER TABLE oc_product_description ADD seo_h1 VARCHAR(255) NOT NULL COLLATE utf8_general_ci AFTER seo_title;

ALTER TABLE oc_product_image ADD sort_order int(3) NOT NULL DEFAULT '0' AFTER image;

ALTER TABLE oc_tax_rate ADD `name` varchar(32) NOT NULL COLLATE utf8_general_ci AFTER geo_zone_id;
ALTER TABLE oc_tax_rate ADD `type` char(1) NOT NULL COLLATE utf8_general_ci AFTER rate;

ALTER TABLE oc_order MODIFY invoice_prefix varchar(26) NOT NULL COLLATE utf8_general_ci;

ALTER TABLE oc_tax_rate MODIFY rate decimal(15,4) NOT NULL DEFAULT '0.0000' AFTER `name`;
ALTER TABLE oc_tax_rate MODIFY date_added DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00' AFTER `type`;
ALTER TABLE oc_tax_rate MODIFY date_modified DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00' AFTER date_added;

ALTER TABLE oc_tax_rate DROP tax_class_id ;
ALTER TABLE oc_tax_rate DROP priority ;
ALTER TABLE oc_tax_rate DROP description ;

ALTER TABLE oc_product_tag ADD INDEX product_id (product_id);
ALTER TABLE oc_product_tag ADD INDEX language_id (language_id);
ALTER TABLE oc_product_tag ADD INDEX tag (tag);

INSERT IGNORE INTO oc_manufacturer_description (manufacturer_id, language_id) SELECT manufacturer_id, language_id FROM oc_manufacturer , oc_language;


#### START UPGRADE OCSTORE 1.5.2

CREATE TABLE IF NOT EXISTS oc_customer_ip_blacklist (
  customer_ip_blacklist_id int(11) NOT NULL auto_increment,
  ip varchar(15) NOT NULL COLLATE utf8_general_ci,
  PRIMARY KEY (customer_ip_blacklist_id),
  INDEX ip (ip)
) DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

CREATE TABLE IF NOT EXISTS oc_order_fraud (
  order_id int(11) NOT NULL DEFAULT 0,
  customer_id int(11) NOT NULL DEFAULT 0,
  country_match varchar(3) NOT NULL COLLATE utf8_general_ci,
  country_code varchar(2) NOT NULL COLLATE utf8_general_ci,
  high_risk_country varchar(3) NOT NULL COLLATE utf8_general_ci,
  distance int(11) NOT NULL DEFAULT 0,
  ip_region varchar(255) NOT NULL COLLATE utf8_general_ci,
  ip_city varchar(255) NOT NULL COLLATE utf8_general_ci,
  ip_latitude decimal(10,6) NOT NULL,
  ip_longitude decimal(10,6) NOT NULL,
  ip_isp varchar(255) NOT NULL COLLATE utf8_general_ci,
  ip_org varchar(255) NOT NULL COLLATE utf8_general_ci,
  ip_asnum int(11) NOT NULL DEFAULT 0,
  ip_user_type varchar(255) NOT NULL COLLATE utf8_general_ci,
  ip_country_confidence varchar(3) NOT NULL COLLATE utf8_general_ci,
  ip_region_confidence varchar(3) NOT NULL COLLATE utf8_general_ci,
  ip_city_confidence varchar(3) NOT NULL COLLATE utf8_general_ci,
  ip_postal_confidence varchar(3) NOT NULL COLLATE utf8_general_ci,
  ip_postal_code varchar(10) NOT NULL COLLATE utf8_general_ci,
  ip_accuracy_radius int(11) NOT NULL DEFAULT 0,
  ip_net_speed_cell varchar(255) NOT NULL COLLATE utf8_general_ci,
  ip_metro_code int(3) NOT NULL DEFAULT 0,
  ip_area_code int(3) NOT NULL DEFAULT 0,
  ip_time_zone varchar(255) NOT NULL COLLATE utf8_general_ci,
  ip_region_name varchar(255) NOT NULL COLLATE utf8_general_ci,
  ip_domain varchar(255) NOT NULL COLLATE utf8_general_ci,
  ip_country_name varchar(255) NOT NULL COLLATE utf8_general_ci,
  ip_continent_code varchar(2) NOT NULL COLLATE utf8_general_ci,
  ip_corporate_proxy varchar(3) NOT NULL COLLATE utf8_general_ci,
  anonymous_proxy varchar(3) NOT NULL COLLATE utf8_general_ci,
  proxy_score int(3) NOT NULL DEFAULT 0,
  is_trans_proxy varchar(3) NOT NULL COLLATE utf8_general_ci,
  free_mail varchar(3) NOT NULL COLLATE utf8_general_ci,
  carder_email varchar(3) NOT NULL COLLATE utf8_general_ci,
  high_risk_username varchar(3) NOT NULL COLLATE utf8_general_ci,
  high_risk_password varchar(3) NOT NULL COLLATE utf8_general_ci,
  bin_match varchar(10) NOT NULL COLLATE utf8_general_ci,
  bin_country varchar(2) NOT NULL COLLATE utf8_general_ci,
  bin_name_match varchar(3) NOT NULL COLLATE utf8_general_ci,
  bin_name varchar(255) NOT NULL COLLATE utf8_general_ci,
  bin_phone_match varchar(3) NOT NULL COLLATE utf8_general_ci,
  bin_phone varchar(32) NOT NULL COLLATE utf8_general_ci,
  customer_phone_in_billing_location varchar(8) NOT NULL COLLATE utf8_general_ci,
  ship_forward varchar(3) NOT NULL COLLATE utf8_general_ci,
  city_postal_match varchar(3) NOT NULL COLLATE utf8_general_ci,
  ship_city_postal_match varchar(3) NOT NULL COLLATE utf8_general_ci,
  score decimal(10,5) NOT NULL,
  explanation text NOT NULL COLLATE utf8_general_ci,
  risk_score decimal(10,5) NOT NULL,
  queries_remaining int(11) NOT NULL DEFAULT 0,
  maxmind_id varchar(8) NOT NULL COLLATE utf8_general_ci,
  error text NOT NULL COLLATE utf8_general_ci,
  date_added datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (order_id)
) DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

CREATE TABLE IF NOT EXISTS oc_order_voucher (
  order_voucher_id int(11) NOT NULL auto_increment,
  order_id int(11) NOT NULL DEFAULT 0,
  voucher_id int(11) NOT NULL DEFAULT 0,
  description varchar(255) NOT NULL COLLATE utf8_general_ci,
  code varchar(10) NOT NULL COLLATE utf8_general_ci,
  from_name varchar(64) NOT NULL COLLATE utf8_general_ci,
  from_email varchar(96) NOT NULL COLLATE utf8_general_ci,
  to_name varchar(64) NOT NULL COLLATE utf8_general_ci,
  to_email varchar(96) NOT NULL COLLATE utf8_general_ci,
  voucher_theme_id int(11) NOT NULL DEFAULT 0,
  message text NOT NULL COLLATE utf8_general_ci,
  amount decimal(15,4) NOT NULL,
  PRIMARY KEY (order_voucher_id)
) DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

ALTER TABLE oc_order ADD shipping_code varchar(128) NOT NULL COLLATE utf8_general_ci AFTER shipping_method;
ALTER TABLE oc_order ADD payment_code varchar(128) NOT NULL COLLATE utf8_general_ci AFTER payment_method;
ALTER TABLE oc_order ADD forwarded_ip varchar(15) NOT NULL COLLATE utf8_general_ci AFTER ip;
ALTER TABLE oc_order ADD user_agent varchar(255) NOT NULL COLLATE utf8_general_ci AFTER forwarded_ip;
ALTER TABLE oc_order ADD accept_language varchar(255) NOT NULL COLLATE utf8_general_ci AFTER user_agent;
ALTER TABLE oc_order DROP reward;

ALTER TABLE oc_order_product ADD reward int(8) NOT NULL DEFAULT 0 AFTER tax;

ALTER TABLE oc_product MODIFY `weight` decimal(15,8) NOT NULL DEFAULT '0.00000000';
ALTER TABLE oc_product MODIFY `length` decimal(15,8) NOT NULL DEFAULT '0.00000000';
ALTER TABLE oc_product MODIFY `width` decimal(15,8) NOT NULL DEFAULT '0.00000000';
ALTER TABLE oc_product MODIFY `height` decimal(15,8) NOT NULL DEFAULT '0.00000000';

ALTER TABLE `oc_return` ADD `product_id` int(11) NOT NULL DEFAULT '0' AFTER `order_id`;
ALTER TABLE `oc_return` ADD `product` varchar(255) NOT NULL COLLATE utf8_general_ci AFTER `telephone`;
ALTER TABLE `oc_return` ADD `model` varchar(64) NOT NULL COLLATE utf8_general_ci AFTER `product`;
ALTER TABLE `oc_return` ADD `quantity` int(4) NOT NULL DEFAULT '0' AFTER `model`;
ALTER TABLE `oc_return` ADD `opened` tinyint(1) NOT NULL DEFAULT '0' AFTER `quantity`;
ALTER TABLE `oc_return` ADD `return_reason_id` int(11) NOT NULL DEFAULT '0' AFTER `opened`;
ALTER TABLE `oc_return` ADD `return_action_id` int(11) NOT NULL DEFAULT '0' AFTER `return_reason_id`;

DROP TABLE oc_return_product;