# nplso2nplch - Lärmempfindlichkeitsstufen

Für die Lieferungen an die Aggregationsinfrastruktur werden die Verweise auf die Dokumente und die Dokumente selbst nicht mitgeliefert. Vergleiche Diskussion an KKGEO-Workshop in Ascona 2015: "Wir machen keinen OEREB mit der AI".


Schemaimport:
```
java -jar ~/apps/ili2pg-3.9.1/ili2pg.jar --dbhost geodb-dev.cgjofbdf5rqg.eu-central-1.rds.amazonaws.com --dbdatabase xanadu2 --dbusr stefan --dbpwd $awsDbPass --nameByTopic --disableValidation --defaultSrsCode 2056 --expandMultilingual --strokeArcs --createGeomIdx --createFkIdx --createEnumTabs --beautifyEnumDispName  --models Laermempfindlichkeitsstufen_LV95_V1_1 --dbschema laerm_ch --schemaimport
```

Export Daten im CH-Modell:
```
java -jar ~/apps/ili2pg-3.9.1/ili2pg.jar --dbhost geodb-dev.cgjofbdf5rqg.eu-central-1.rds.amazonaws.com --dbdatabase xanadu2 --dbusr stefan --dbpwd $awsDbPass --nameByTopic --disableValidation --defaultSrsCode 2056 --disableValidation --expandMultilingual --strokeArcs --createGeomIdx --createFkIdx --createEnumTabs --beautifyEnumDispName  --models Laermempfindlichkeitsstufen_LV95_V1_1 --dbschema laerm_ch --export larm_ch.xtf
```

```
xmllint --format larm_ch.xtf -o larm_ch.xtf
```

```
java -jar ~/Apps/ilivalidator-1.5.0/ilivalidator.jar larm_ch.xtf
```

## Aggregationsinfrastruktur

Einmalig zuerst in AI konfigurieren. -> Screenshot. -> Freischalten unter Angebot nicht vergessen.

```
curl -X POST -u $aiAdminLogin:$aiAdminPass -F "topic=npl_nutzungsplanung" -F "lv95_file=@nplso_ch.xtf.zip" -F "publish=true" "https://integration.geodienste.ch/data_agg/interlis/import"
```

```
curl -X POST -u $aiAdminLogin:$aiAdminPass -F "topic=npl_nutzungsplanung" -F "lv95_file=@nplso_ch.xtf.zip" -F "publish=true" "https://www.geodienste.ch/data_agg/interlis/import"
```

Zuerst in Integration (zusätzliches basic auth für admin seite: XXXXXX/YYYYYY):

WMS: https://integration.geodienste.ch/db/npl_nutzungsplanung/deu?
