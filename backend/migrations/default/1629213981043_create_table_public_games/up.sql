CREATE EXTENSION IF NOT EXISTS pgcrypto;
CREATE TABLE "public"."games"("id" uuid NOT NULL DEFAULT gen_random_uuid(), "name" text, "creator" text, "image" text, "description" text,"released_at" text, "players" text, "age" text, "duration" text,  "created_at" timestamptz NOT NULL DEFAULT now(), "updated_at" timestamptz NOT NULL DEFAULT now(), PRIMARY KEY ("id") );
CREATE OR REPLACE FUNCTION "public"."set_current_timestamp_updated_at"()
RETURNS TRIGGER AS $$
DECLARE
  _new record;
BEGIN
  _new := NEW;
  _new."updated_at" = NOW();
  RETURN _new;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER "set_public_games_updated_at"
BEFORE UPDATE ON "public"."games"
FOR EACH ROW
EXECUTE PROCEDURE "public"."set_current_timestamp_updated_at"();
COMMENT ON TRIGGER "set_public_games_updated_at" ON "public"."games" 
IS 'trigger to set value of column "updated_at" to current timestamp on row update';
