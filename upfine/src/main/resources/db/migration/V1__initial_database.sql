DROP TABLE IF EXISTS "tb_corporation" CASCADE;
CREATE TABLE "tb_corporation" (
  "id" INT8 GENERATED BY DEFAULT AS IDENTITY,
  "cnpj" varchar(255) NOT NULL,
  "name" varchar(255) NOT NULL,
  "created_at" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_at" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "deleted_at" TIMESTAMP WITH TIME ZONE DEFAULT NULL,
  PRIMARY KEY ("id")
);
CREATE UNIQUE INDEX "id_corporation_UNIQUE" ON "tb_corporation" ("id" ASC);


DROP TABLE IF EXISTS "tb_ipe" CASCADE;
CREATE TABLE "tb_ipe" (
  "id" INT8 GENERATED BY DEFAULT AS IDENTITY,
  "corporation_id" INT8 NOT NULL,
  "subject" TEXT NOT NULL,
  "link" TEXT NOT NULL,
  "reference_date" DATE NOT NULL,
  "created_at" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_at" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "deleted_at" TIMESTAMP WITH TIME ZONE DEFAULT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "fk_tb_ipe_tb_corporation" FOREIGN KEY ("corporation_id") REFERENCES "tb_corporation" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE UNIQUE INDEX "id_ipe_UNIQUE" ON "tb_ipe" ("id" ASC);
CREATE INDEX "fk_tb_ipe_tb_corporation_idx" ON "tb_ipe" ("corporation_id" ASC);


DROP TABLE IF EXISTS "tb_relevant_fact" CASCADE;
CREATE TABLE "tb_relevant_fact" (
  "id" INT8 GENERATED BY DEFAULT AS IDENTITY,
  "ipe_id" INT8 NOT NULL,
  "summarized" TEXT NOT NULL,
  "created_at" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_at" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "deleted_at" TIMESTAMP WITH TIME ZONE DEFAULT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "fk_tb_relevant_fact_tb_ipe" FOREIGN KEY ("ipe_id") REFERENCES "tb_ipe" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE UNIQUE INDEX "id_relevant_fact_UNIQUE" ON "tb_relevant_fact" ("id" ASC);
CREATE INDEX "fk_tb_relevant_fact_tb_ipe_idx" ON "tb_relevant_fact" ("ipe_id" ASC);


DROP TABLE IF EXISTS "tb_user" CASCADE;
CREATE TABLE "tb_user" (
  "id" INT8 GENERATED BY DEFAULT AS IDENTITY,
  "name" VARCHAR(255) NOT NULL,
  "email" VARCHAR(255) NOT NULL,
  "active" BOOLEAN NOT NULL DEFAULT TRUE,
  "reference_date" DATE NOT NULL,
  "created_at" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_at" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "deleted_at" TIMESTAMP WITH TIME ZONE DEFAULT NULL,
  PRIMARY KEY ("id"),
  UNIQUE(email)
);
CREATE UNIQUE INDEX "id_user_UNIQUE" ON "tb_user" ("id" ASC);


DROP TABLE IF EXISTS "tb_config" CASCADE;
CREATE TABLE "tb_config" (
  "id" INT8 GENERATED BY DEFAULT AS IDENTITY,
  "name" VARCHAR(255) NOT NULL,
  "value" VARCHAR(255) NOT NULL,
  "created_at" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_at" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "deleted_at" TIMESTAMP WITH TIME ZONE DEFAULT NULL,
  PRIMARY KEY ("id")
);
CREATE UNIQUE INDEX "id_config_UNIQUE" ON "tb_config" ("id" ASC);


DROP TABLE IF EXISTS "tb_pivot_corporation_user" CASCADE;
CREATE TABLE "tb_pivot_corporation_user" (
  "id" INT8 GENERATED BY DEFAULT AS IDENTITY,
  "corporation_id" INT8 NOT NULL,
  "user_id" INT8 NOT NULL,
  "created_at" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_at" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "deleted_at" TIMESTAMP WITH TIME ZONE DEFAULT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "fk_tb_pivot_corporation_user_tb_corporation" FOREIGN KEY ("corporation_id") REFERENCES "tb_corporation" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT "fk_tb_pivot_corporation_user_tb_user" FOREIGN KEY ("user_id") REFERENCES "tb_user" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE UNIQUE INDEX "id_tb_pivot_corporation_user_UNIQUE" ON "tb_pivot_corporation_user" ("id" ASC);
CREATE INDEX "fk_tb_pivot_corporation_user_tb_corporation_idx" ON "tb_pivot_corporation_user" ("corporation_id" ASC);
CREATE INDEX "fk_tb_pivot_corporation_user_tb_user_idx" ON "tb_pivot_corporation_user" ("user_id" ASC);



INSERT INTO "tb_config"(name, value) VALUES ('GPT-API-URL', 'https://api.openai.com/v1/engine/ada/completions');
INSERT INTO "tb_config"(name, value) VALUES ('GPT-API-KEY', 'api-key');
INSERT INTO "tb_config"(name, value) VALUES ('GPT-API-PROMPT', 'Por favor, resuma em principais pontos o seguinte texto que está em português. O texto será utilizado em um noticiário breve, direcionado para investidores do mercado de ações.');
INSERT INTO "tb_config"(name, value) VALUES ('GPT-API-KEY', 'Bearer api-key');
INSERT INTO "tb_config"(name, value) VALUES ('ZIP-FILE-URL', 'https://dados.cvm.gov.br/dados/CIA_ABERTA/DOC/IPE/DADOS/ipe_cia_aberta_2023.zip');
INSERT INTO "tb_config"(name, value) VALUES ('ZIP-FILE-PATH-STR', 'src/main/resources/zip/ipe_cia_aberta_2023.zip');
INSERT INTO "tb_config"(name, value) VALUES ('CSV-FILE-PATH-STR', 'src/main/resources/csv/ipe_cia_aberta_2023.zip');
INSERT INTO "tb_config"(name, value) VALUES ('CHARSET-PATTERN', 'ISO-8859-1');

INSERT INTO "tb_config"(name, value) VALUES ('SSL-CERTIFICATE-PATH', 'src/main/resources/ssl-certificate/certificate.pem');
INSERT INTO "tb_config"(name, value) VALUES ('SSL-CERTIFICATE-TYPE', 'X.509');

INSERT INTO "tb_config"(name, value) VALUES ('REQUEST-MEDIA-TYPE', 'application/json');

INSERT INTO "tb_config"(name, value) VALUES ('EMAIL-SENDER', 'danielbaudocla@gmail.com');
INSERT INTO "tb_config"(name, value) VALUES ('TEMPLATE_RELEVANT_FACT_NAME', 'template_relevant_fact');
INSERT INTO "tb_config"(name, value) VALUES ('TEMPLATE_RELEVANT_FACT_PREFIX_PATH', 'templates/');
INSERT INTO "tb_config"(name, value) VALUES ('TEMPLATE_RELEVANT_FACT_SUFIX_PATH', '.html');