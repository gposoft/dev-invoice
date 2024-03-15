CREATE SCHEMA "products"
;

CREATE SCHEMA "store"
;

CREATE SCHEMA "providers"
;

CREATE SCHEMA "catalogs"
;

-- Create tables section -------------------------------------------------

-- Table products.product

CREATE TABLE IF NOT EXISTS "products"."product"
(
  "product_id" Character varying(40) DEFAULT left(replace(((gen_random_uuid())::character varying) ,'-','')  ,40) NOT NULL,
  "code" Text NOT NULL,
  "name" Text NOT NULL,
  "description" Text,
  "sort" Text DEFAULT '0' NOT NULL
)
WITH (
  autovacuum_enabled=true)
;

ALTER TABLE "products"."product" ADD CONSTRAINT "PK_product" PRIMARY KEY ("product_id")
;

-- Table store.client

CREATE TABLE IF NOT EXISTS "store"."client"
(
  "client_id" Character varying(40) DEFAULT left(replace(((gen_random_uuid())::character varying) ,'-','')  ,40) NOT NULL,
  "code" Text NOT NULL,
  "first_name" Text NOT NULL,
  "second_name" Text NOT NULL,
  "name" Text NOT NULL
)
WITH (
  autovacuum_enabled=true)
;

ALTER TABLE "store"."client" ADD CONSTRAINT "PK_client" PRIMARY KEY ("client_id")
;

-- Table store.invoice

CREATE TABLE IF NOT EXISTS "store"."invoice"
(
  "invoice_id" Character varying(40) DEFAULT left(replace(((gen_random_uuid())::character varying) ,'-','')  ,40) NOT NULL,
  "state" Text NOT NULL,
  "folio" Text NOT NULL,
  "date" Date NOT NULL,
  "concept" Text NOT NULL
)
WITH (
  autovacuum_enabled=true)
;

ALTER TABLE "store"."invoice" ADD CONSTRAINT "PK_invoice" PRIMARY KEY ("invoice_id")
;

-- Table catalogs.catalog

CREATE TABLE IF NOT EXISTS "catalogs"."catalog"
(
  "catalog_id" Character varying(40) DEFAULT left(replace(((gen_random_uuid())::character varying) ,'-','')  ,40) NOT NULL,
  "type" Text NOT NULL,
  "code" Text NOT NULL,
  "name" Text NOT NULL,
  "description" Text,
  "sort" Text DEFAULT '0' NOT NULL
)
WITH (
  autovacuum_enabled=true)
;

ALTER TABLE "catalogs"."catalog" ADD CONSTRAINT "PK_catalog" PRIMARY KEY ("catalog_id")
;

-- Table products.product_movto

CREATE TABLE IF NOT EXISTS "products"."product_movto"
(
  "product_movto_id" Character varying(40) DEFAULT left(replace(((gen_random_uuid())::character varying) ,'-','')  ,40) NOT NULL,
  "product_id" Character varying(40) NOT NULL,
  "operation" Character varying(20) NOT NULL,
  "date" Timestamp(6) DEFAULT CURRENT_TIMESTAMP NOT NULL,
  "quantity" Integer NOT NULL,
  "price" Numeric NOT NULL,
  "description" Text,
  "sort" Text DEFAULT '0' NOT NULL
)
WITH (
  autovacuum_enabled=true)
;

ALTER TABLE "products"."product_movto" ADD CONSTRAINT "PK_product_movto" PRIMARY KEY ("product_movto_id")
;

-- Table products.product_catalog

CREATE TABLE "products"."product_catalog"
(
  "product_catalog_id" Character varying(40) DEFAULT left(replace(((gen_random_uuid())::character varying) ,'-','')  ,40) NOT NULL,
  "product_id" Character varying(40) NOT NULL,
  "catalog_id" Character varying(40) NOT NULL
)
WITH (
  autovacuum_enabled=true)
;

ALTER TABLE "products"."product_catalog" ADD CONSTRAINT "PK_product_catalog" PRIMARY KEY ("product_catalog_id")
;

-- Table store.invoice_client

CREATE TABLE "store"."invoice_client"
(
  "invoice_client_id" Character varying(40) DEFAULT left(replace(((gen_random_uuid())::character varying) ,'-','')  ,40) NOT NULL,
  "invoice_id" Character varying(40),
  "client_id" Character varying(40)
)
WITH (
  autovacuum_enabled=true)
;

ALTER TABLE "store"."invoice_client" ADD CONSTRAINT "PK_invoice_client" PRIMARY KEY ("invoice_client_id")
;

-- Table store.invoice_details

CREATE TABLE "store"."invoice_details"
(
  "invoice_detail_id" Character varying(40) DEFAULT left(replace(((gen_random_uuid())::character varying) ,'-','')  ,40) NOT NULL,
  "invoice_id" Character varying(40) NOT NULL,
  "cant" Numeric NOT NULL,
  "concept" Text NOT NULL,
  "amount" Numeric NOT NULL
)
WITH (
  autovacuum_enabled=true)
;

ALTER TABLE "store"."invoice_details" ADD CONSTRAINT "PK_invoice_details" PRIMARY KEY ("invoice_detail_id")
;

-- Table products.product_movto_catalog

CREATE TABLE "products"."product_movto_catalog"
(
  "product_movto_catalog_id" Character varying(40) DEFAULT left(replace(((gen_random_uuid())::character varying) ,'-','')  ,40) NOT NULL,
  "product_movto_id" Character varying(40) NOT NULL,
  "operation_id" Character varying(40) NOT NULL
)
WITH (
  autovacuum_enabled=true)
;

ALTER TABLE "products"."product_movto_catalog" ADD CONSTRAINT "PK_product_movto_catalog" PRIMARY KEY ("product_movto_catalog_id")
;

-- Create foreign keys (relationships) section -------------------------------------------------

ALTER TABLE "products"."product_movto"
  ADD CONSTRAINT "rel_product_movto"
    FOREIGN KEY ("product_id")
    REFERENCES "products"."product" ("product_id")
      ON DELETE CASCADE
      ON UPDATE NO ACTION
;

ALTER TABLE "products"."product_catalog"
  ADD CONSTRAINT "rel_product_catalog"
    FOREIGN KEY ("product_id")
    REFERENCES "products"."product" ("product_id")
      ON DELETE CASCADE
      ON UPDATE NO ACTION
;

ALTER TABLE "products"."product_catalog"
  ADD CONSTRAINT "rel_catalog_product"
    FOREIGN KEY ("catalog_id")
    REFERENCES "catalogs"."catalog" ("catalog_id")
      ON DELETE CASCADE
      ON UPDATE NO ACTION
;

ALTER TABLE "products"."product_movto_catalog"
  ADD CONSTRAINT "rel_product_movto_catalog"
    FOREIGN KEY ("product_movto_id")
    REFERENCES "products"."product_movto" ("product_movto_id")
      ON DELETE CASCADE
      ON UPDATE NO ACTION
;

ALTER TABLE "products"."product_movto_catalog"
  ADD CONSTRAINT "rel_catalog_product_movto"
    FOREIGN KEY ("operation_id")
    REFERENCES "catalogs"."catalog" ("catalog_id")
      ON DELETE CASCADE
      ON UPDATE NO ACTION
;

ALTER TABLE "store"."invoice_details"
  ADD CONSTRAINT "invoice_detail"
    FOREIGN KEY ("invoice_id")
    REFERENCES "store"."invoice" ("invoice_id")
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
;

ALTER TABLE "store"."invoice_client"
  ADD CONSTRAINT "rel_invoice_client"
    FOREIGN KEY ("invoice_id")
    REFERENCES "store"."invoice" ("invoice_id")
      ON DELETE CASCADE
      ON UPDATE NO ACTION
;

ALTER TABLE "store"."invoice_client"
  ADD CONSTRAINT "rel_client_invoice"
    FOREIGN KEY ("client_id")
    REFERENCES "store"."client" ("client_id")
      ON DELETE CASCADE
      ON UPDATE NO ACTION
;

