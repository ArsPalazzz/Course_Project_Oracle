GRANT CREATE ANY DIRECTORY TO OTHERUSERCORE WITH ADMIN OPTION;
GRANT EXECUTE ON dbms_crypto TO OTHERUSERCORE WITH GRANT OPTION;
GRANT EXECUTE ON dbms_xmldom TO OTHERUSERCORE WITH GRANT OPTION;
GRANT EXECUTE ON dbms_xslprocessor TO OTHERUSERCORE WITH GRANT OPTION;
GRANT EXECUTE ON dbms_xmlparser TO OTHERUSERCORE WITH GRANT OPTION;
GRANT EXECUTE ON dbms_xmldom TO OTHERUSERCORE WITH GRANT OPTION;
GRANT EXECUTE ON dbms_lob TO OTHERUSERCORE WITH GRANT OPTION;



SELECT file_name FROM dba_data_files; 
CREATE OR REPLACE DIRECTORY EXPORT_DATA AS 
'D:\xml';
GRANT READ, WRITE ON DIRECTORY EXPORT_DATA TO OTHERUSERCORE;
GRANT READ, WRITE ON DIRECTORY IMPORT_DATA TO OTHERUSERCORE;


CREATE OR REPLACE DIRECTORY IMPORT_DATA AS 
'D:\xml';

drop procedure EXPORT_Songs_TO_XML;

CREATE OR REPLACE PROCEDURE EXPORT_Songs_TO_XML
IS
 doc DBMS_XMLDOM.DOMDocument;
 xdata XMLTYPE;
 CURSOR xmlcur IS
 SELECT XMLELEMENT(
 "Songs",
 XMLAttributes('http://www.w3.org/2001/XMLSchema' AS 
"xmlns:xsi",
 'http://www.oracle.com/Users.xsd' AS 
"xsi:nonamespaceSchemaLocation"),
 XMLAGG(XMLELEMENT("Song",
 xmlelement("song_id", OTHERUSERCORE.Song.song_id),
 xmlelement("song_name", OTHERUSERCORE.Song.song_name),
 xmlelement("artist_name", OTHERUSERCORE.Song.artist_name),
 xmlelement("album_name", OTHERUSERCORE.Song.album_name),
 xmlelement("side", OTHERUSERCORE.Song.side)
 ))) from OTHERUSERCORE.Song;
BEGIN
open xmlcur;
 LOOP
 FETCH xmlcur INTO xdata;
 EXIT WHEN xmlcur%notfound;
 END LOOP;
 CLOSE xmlcur;
 doc := DBMS_XMLDOM.NewDOMDocument(xdata);
 DBMS_XMLDOM.WRITETOFILE(doc, 'EXPORT_DATA/Songs.xml');
END;

exec EXPORT_Songs_TO_XML;

begin
    IMPORT_Songs_FROM_XML();
end;
-----------------------IMPORT-------------------------------

CREATE OR REPLACE PROCEDURE IMPORT_Songs_FROM_XML
IS
L_CLOB CLOB;
L_BFILE BFILE := BFILENAME('IMPORT_DATA', 'Songs.xml');
L_DEST_OFFSET INTEGER := 1;
L_SRC_OFFSET INTEGER := 1;
L_BFILE_CSID NUMBER := 0;
L_LANG_CONTEXT INTEGER := 0;
L_WARNING INTEGER := 0;
P DBMS_XMLPARSER.PARSER;
V_DOC DBMS_XMLDOM.DOMDOCUMENT;
V_ROOT_ELEMENT DBMS_XMLDOM.DOMELEMENT;
V_CHILD_NODES DBMS_XMLDOM.DOMNODELIST;
V_CURRENT_NODE DBMS_XMLDOM.DOMNODE;
cl OTHERUSERCORE.Song%ROWTYPE;
BEGIN
DBMS_LOB.CREATETEMPORARY (L_CLOB, TRUE);
DBMS_LOB.FILEOPEN(L_BFILE, DBMS_LOB.FILE_READONLY);
DBMS_LOB.LOADCLOBFROMFILE(DEST_LOB => L_CLOB, SRC_BFILE => L_BFILE, AMOUNT => DBMS_LOB.LOBMAXSIZE, DEST_OFFSET => L_DEST_OFFSET, SRC_OFFSET => L_SRC_OFFSET, BFILE_CSID => L_BFILE_CSID, LANG_CONTEXT => L_LANG_CONTEXT, WARNING => L_WARNING);
DBMS_LOB.FILECLOSE(L_BFILE);
COMMIT;
P := DBMS_XMLPARSER.NEWPARSER;
DBMS_XMLPARSER.PARSECLOB(P, L_CLOB);
V_DOC := DBMS_XMLPARSER.GETDOCUMENT(P);
V_ROOT_ELEMENT := DBMS_XMLDOM.Getdocumentelement(V_DOC);
V_CHILD_NODES := DBMS_XMLDOM.GETCHILDRENBYTAGNAME(V_ROOT_ELEMENT, '*');
FOR i IN 0 .. DBMS_XMLDOM.GETLENGTH(V_CHILD_NODES) - 1 LOOP
V_CURRENT_NODE := DBMS_XMLDOM.ITEM(V_CHILD_NODES, i);
DBMS_XSLPROCESSOR.VALUEOF(V_CURRENT_NODE, 'song_id/text()', cl.song_id);
DBMS_XSLPROCESSOR.VALUEOF(V_CURRENT_NODE, 'song_name/text()', cl.song_name);
DBMS_XSLPROCESSOR.VALUEOF(V_CURRENT_NODE, 'artist_name/text()', cl.artist_name);
DBMS_XSLPROCESSOR.VALUEOF(V_CURRENT_NODE, 'album_name/text()', cl.album_name);
DBMS_XSLPROCESSOR.VALUEOF(V_CURRENT_NODE, 'side/text()', cl.side);
INSERT INTO OTHERUSERCORE.Song (song_id, song_name, artist_name, album_name, side) VALUES (cl.song_id, cl.song_name, cl.artist_name, cl.album_name, cl.side);
END LOOP;
DBMS_LOB.FREETEMPORARY(L_CLOB);
DBMS_XMLPARSER.FREEPARSER(P);
DBMS_XMLDOM.FREEDOCUMENT(V_DOC);
COMMIT;
END;


select * from client

EXPLAIN PLAN FOR
SELECT * FROM otherusercore.Song s join otherusercore.Song_Record rec
on s.song_id = rec.song_id;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

create index index123 on otherusercore.song_record(song_id);
