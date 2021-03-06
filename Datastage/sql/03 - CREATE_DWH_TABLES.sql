CREATE SEQUENCE DWH.ARCHIVE_DWP_ID_SEQ
  START WITH 100
  MAXVALUE 9999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  CACHE 20
  NOORDER;

GRANT SELECT ON DWH.ARCHIVE_DWP_ID_SEQ TO DWHADM;


CREATE TABLE DWH.ARCHIVE_DWP
(
  ID         NUMBER                             NOT NULL,
  FILE_NAME  VARCHAR2(256 BYTE),
  FILE_SIZE  INTEGER,
  CURR_F     NUMBER(1),
  PPN_DT     DATE                               NOT NULL,
  FILE_BODY  BLOB
);

COMMENT ON TABLE DWH.ARCHIVE_DWP IS 'List of .zip-files';

COMMENT ON COLUMN DWH.ARCHIVE_DWP.ID IS 'Identifier of .zip-file';
COMMENT ON COLUMN DWH.ARCHIVE_DWP.FILE_NAME IS 'Name of .zip-file';
COMMENT ON COLUMN DWH.ARCHIVE_DWP.FILE_NAME IS 'Size of .zip-file';
COMMENT ON COLUMN DWH.ARCHIVE_DWP.CURR_F IS 'Flag of actuality: 1 - actual, 0 - not actual';
COMMENT ON COLUMN DWH.ARCHIVE_DWP.PPN_DT IS 'Date of uploading';
COMMENT ON COLUMN DWH.ARCHIVE_DWP.FILE_BODY IS 'Binary contents of .zip-file'; 

CREATE UNIQUE INDEX DWH.ARCHIVE_DWP_ID_PK ON DWH.ARCHIVE_DWP(ID);

CREATE OR REPLACE TRIGGER DWH.ARCHIVE_DWP_ID_TRG
BEFORE INSERT
ON DWH.ARCHIVE_DWP
FOR EACH ROW
WHEN (
new.id is null
      )
BEGIN
  select dwh.archive_dwp_id_seq.nextval into :new.id from dual;
END;
/


ALTER TABLE DWH.ARCHIVE_DWP ADD (
  CONSTRAINT ARCHIVE_DWP_ID_PK
  PRIMARY KEY
  (ID)
  USING INDEX DWH.ARCHIVE_DWP_ID_PK
  ENABLE VALIDATE);

GRANT DELETE, INSERT, SELECT, UPDATE ON DWH.ARCHIVE_DWP TO DWHADM;
