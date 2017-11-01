DELETE FROM npl_ch.geobasisdaten_typ_kt;
DELETE FROM npl_ch.geobasisdaten_typ;
DELETE FROM npl_ch.geobasisdaten_grundnutzung_zonenflaeche;
DELETE FROM npl_ch.rechtsvorschrften_dokument;
DELETE FROM npl_ch.localiseduri;
DELETE FROM npl_ch.multilingualuri;
DELETE FROM npl_ch.rechtsvorschrften_hinweisweiteredokumente;
DELETE FROM npl_ch.geobasisdaten_typ_dokument;

/*
 * GRUNDNUTZUNG START
 */
WITH typ_kt AS
(
  INSERT INTO npl_ch.geobasisdaten_typ_kt
    (
      code,
      bezeichnung,
      abkuerzung,
      hauptnutzung_ch
    )
  SELECT
    substring(ilicode FROM 2 FOR 3) AS code, 
    replace(substring(ilicode FROM 6), '_', ' ') AS bezeichnung, 
    substring(ilicode FROM 1 FOR 4) AS abkuerzung,
    hn.t_id AS hauptnutzung_ch
  FROM
    npl_so.nutzungsplanung_np_typ_kanton_grundnutzung AS gn
    LEFT JOIN 
      npl_ch.hauptnutzung_ch_hauptnutzung_ch AS hn
      ON 
        hn.code::text = substring(ilicode FROM 2 FOR 2)
  RETURNING *
),
/*
 * We cannot just insert the records since we need 
 * to reference some of them and we don't have unique
 * identifiers AFTER inserting (e.g. same code_kommunal 
 * for almost every municipalitiy).
 */ 
typ_kommunal AS 
(
  SELECT 
    nextval('npl_ch.t_ili2db_seq'::regclass) AS t_id,
    typ.t_id AS nutzungsplanung_typ_grundnutzung_t_id,
    typ.code_kommunal AS code,
    typ.bezeichnung,
    typ.abkuerzung,
    typ.verbindlichkeit,
    typ.nutzungsziffer,
    typ.nutzungsziffer_art,
    typ.bemerkungen,
    typ_kt.t_id AS typ_kt
  FROM
    npl_so.nutzungsplanung_typ_grundnutzung AS typ
    LEFT JOIN
      typ_kt
      ON
        typ_kt.code = substring(typ.typ_kt FROM 2 FOR 3)
),
grundnutzung_zonenflaeche AS 
(
  SELECT
    nextval('npl_ch.t_ili2db_seq'::regclass) AS t_id,
    grundnutzung.t_id AS nutzungsplanung_grundnutzung_t_id,
    grundnutzung.publiziertab,
    grundnutzung.rechtsstatus,
    grundnutzung.bemerkungen,
    typ_kommunal.t_id AS typ,
    grundnutzung.geometrie
  FROM
    npl_so.nutzungsplanung_grundnutzung AS grundnutzung
    LEFT JOIN typ_kommunal
    ON grundnutzung.typ_grundnutzung = typ_kommunal.nutzungsplanung_typ_grundnutzung_t_id
),
typ_kommunal_insert AS
(
  INSERT INTO npl_ch.geobasisdaten_typ
    (
      t_id,
      code,
      bezeichnung,
      abkuerzung,
      verbindlichkeit,
      nutzungsziffer,
      nutzungsziffer_art,
      bemerkungen,
      typ_kt
    )
  SELECT 
    t_id,
    code,
    bezeichnung,
    abkuerzung,
    verbindlichkeit,
    nutzungsziffer,
    nutzungsziffer_art,
    bemerkungen,
    typ_kt
  FROM
    typ_kommunal
  RETURNING *
),
grundnutzung_zonenflaeche_insert AS
(
  INSERT INTO npl_ch.geobasisdaten_grundnutzung_zonenflaeche
    (
      t_id,
      publiziertab,
      rechtsstatus,
      bemerkungen,
      typ,
      geometrie
    )
  SELECT
    t_id,
    publiziertab,
    rechtsstatus,
    bemerkungen,
    typ,
    geometrie
  FROM
    grundnutzung_zonenflaeche
  RETURNING *
),
rechtsvorschrften_dokument AS (
  SELECT
    nextval('npl_ch.t_ili2db_seq'::regclass) AS t_id,
    t_id AS rechtsvorschrften_dokument_t_id,
    CASE 
      WHEN rechtsvorschrift IS TRUE THEN 'rechtsvorschrften_rechtsvorschrift'
      ELSE 'rechtsvorschrften_dokument'
    END AS t_type,
    titel,
    offiziellertitel,
    abkuerzung,
    kanton,
    gemeinde,
    publiziertab,
    rechtsstatus,
    bemerkungen,
    'https://geoweb.so.ch/zonenplaene/Zonenplaene_pdf/' || textimweb AS textimweb
  FROM
    npl_so.rechtsvorschrften_dokument
),
rechtsvorschrften_dokument_insert AS (
  INSERT INTO npl_ch.rechtsvorschrften_dokument
    (
      t_id,
      t_type,
      titel,
      offiziellertitel,
      abkuerzung,
      kanton,
      gemeinde,
      publiziertab,
      rechtsstatus,
      bemerkungen
    )
  SELECT
      t_id,
      t_type,
      titel,
      offiziellertitel,
      abkuerzung,
      kanton,
      gemeinde,
      publiziertab,
      rechtsstatus,
      bemerkungen
  FROM
    rechtsvorschrften_dokument
  RETURNING * 
),
multilingualuri_localiseduri_dokument AS (
  SELECT
    nextval('npl_ch.t_ili2db_seq'::regclass) AS t_id, -- multilingualuri t_id.
    t_id AS rechtsvorschrften_dokument_t_id,
    textimweb AS atext,
    'de' AS alanguage
  FROM
    rechtsvorschrften_dokument
),
multilingualuri_dokument_insert AS (
  INSERT INTO npl_ch.multilingualuri 
    (
      t_id,
      rechtsvrschrftn_dkment_textimweb
    )
    SELECT
      t_id,
      rechtsvorschrften_dokument_t_id
    FROM
      multilingualuri_localiseduri_dokument  
    RETURNING *
),
localiseduri_dokument_insert AS (
  INSERT INTO npl_ch.localiseduri
  (
    alanguage,
    atext,
    multilingualuri_localisedtext
  )
  SELECT 
    alanguage,
    atext,
    t_id
  FROM
    multilingualuri_localiseduri_dokument
  RETURNING *
),
-- cross reference table: rechtsvorschrften_hinweisweiteredokumente
rechtsvorschrften_hinweisweiteredokumente_insert AS 
(
  INSERT INTO npl_ch.rechtsvorschrften_hinweisweiteredokumente
    (
      ursprung,
      hinweis
    )
  SELECT
    u.ursprung,
    d.t_id AS hinweis
  FROM 
  (
    SELECT
      d.t_id AS ursprung,
      hwd.hinweis
    FROM 
      rechtsvorschrften_dokument AS d 
      LEFT JOIN npl_so.rechtsvorschrften_hinweisweiteredokumente AS hwd
      ON d.rechtsvorschrften_dokument_t_id = hwd.ursprung
    WHERE
      hwd.ursprung IS NOT NULL
  ) AS u
  LEFT JOIN rechtsvorschrften_dokument AS d 
  ON d.rechtsvorschrften_dokument_t_id = u.hinweis
  RETURNING *
),
geobasisdaten_typ_dokument AS 
(
  INSERT INTO npl_ch.geobasisdaten_typ_dokument 
    (
      typ,
      vorschrift
    )
  SELECT
    tg.typ,
    d.t_id AS vorschrift
  FROM
  (
    SELECT
      typ.t_id AS typ,
      tgd.dokument
    FROM
      typ_kommunal AS typ 
      LEFT JOIN npl_so.nutzungsplanung_typ_grundnutzung_dokument AS tgd
      ON typ.nutzungsplanung_typ_grundnutzung_t_id = tgd.typ_grundnutzung
    WHERE
      tgd.typ_grundnutzung IS NOT NULL
  ) AS tg 
  LEFT JOIN rechtsvorschrften_dokument AS d 
  ON d.rechtsvorschrften_dokument_t_id  = tg.dokument
  RETURNING *
)
/*
 * GRUNDNUTZUNG ENDE
 */

SELECT
  *
FROM
  geobasisdaten_typ_dokument
  

