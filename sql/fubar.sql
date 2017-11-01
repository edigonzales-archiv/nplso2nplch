/*
SELECT
  *
FROM 
  npl_so.nutzungsplanung_ueberlagernd_flaeche AS fl
  LEFT JOIN npl_so.nutzungsplanung_typ_ueberlagernd_flaeche fl_typ
  ON fl.typ_ueberlagernd_flaeche = fl_typ.t_id
  
  */

/*
SELECT
  *
FROM 
  npl_so.nutzungsplanung_typ_grundnutzung AS typ 
  LEFT JOIN npl_so.nutzungsplanung_typ_grundnutzung_dokument AS m 
  ON m.typ_grundnutzung = typ.t_id
*/

SELECT 
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
  'https://geoweb.so.ch/zonenplaene/Zonenplaene_pdf/' || textimweb
FROM
  npl_so.rechtsvorschrften_dokument
  
  
