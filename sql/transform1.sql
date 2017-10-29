DELETE FROM npl_ch.geobasisdaten_typ_kt;
DELETE FROM npl_ch.geobasisdaten_typ;

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
/*
 * Now do the INSERTs.
 */
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
)

SELECT
  *
FROM
  grundnutzung_zonenflaeche_insert




  
  

