# nplso2nplch

Schemaimport mit allen benötigten Modellen:
```
java -jar ~/apps/ili2pg-3.9.1/ili2pg.jar --dbhost geodb-dev.cgjofbdf5rqg.eu-central-1.rds.amazonaws.com --dbdatabase xanadu2 --dbusr stefan --dbpwd XXXXXX --nameByTopic --disableValidation --defaultSrsCode 2056 --expandMultilingual --strokeArcs --createGeomIdx --createFkIdx --createEnumTabs --beautifyEnumDispName  --models "Nutzungsplanung_Hauptnutzung_V1_1;Nutzungsplanung_LV95_V1_1" --dbschema npl_ch --schemaimport
```

Import der CH-Hauptnutzungen:
```
java -jar ~/apps/ili2pg-3.9.1/ili2pg.jar --dbhost geodb-dev.cgjofbdf5rqg.eu-central-1.rds.amazonaws.com --dbdatabase xanadu2 --dbusr stefan --dbpwd XXXXXX --nameByTopic --disableValidation --defaultSrsCode 2056 --expandMultilingual --strokeArcs --createGeomIdx --createFkIdx --createEnumTabs --beautifyEnumDispName  --models Nutzungsplanung_Hauptnutzung_V1_1 --dbschema npl_ch --import Hauptnutzung_CH_V1_1.xml
```

Import SO-Testdatensatz im SO-Modell:
```
java -jar ~/apps/ili2pg-3.9.1/ili2pg.jar --dbhost geodb-dev.cgjofbdf5rqg.eu-central-1.rds.amazonaws.com --dbdatabase xanadu2 --dbusr stefan --dbpwd XXXXXX --nameByTopic --disableValidation --defaultSrsCode 2056 --strokeArcs --createGeomIdx --createFkIdx --createEnumTabs --beautifyEnumDispName  --models SO_Nutzungsplanung_20170915 --createBasketCol --createDatasetCol --dbschema npl_so --dataset 2502 --import exp1_wis_20170926_umbau.xtf
```

```
java -jar ~/apps/ili2pg-3.9.1/ili2pg.jar --dbhost geodb-dev.cgjofbdf5rqg.eu-central-1.rds.amazonaws.com --dbdatabase xanadu2 --dbusr stefan --dbpwd XXXXXX --nameByTopic --disableValidation --defaultSrsCode 2056 --strokeArcs --createGeomIdx --createFkIdx --createEnumTabs --beautifyEnumDispName  --models SO_Nutzungsplanung_20170915 --createBasketCol --createDatasetCol --dbschema npl_so --dataset 2502 --export exp1_wis_20170926_umbau_extra_assoz.xtf
```


Export Daten im CH-Modell:
```
java -jar ~/apps/ili2pg-3.9.1/ili2pg.jar --dbhost geodb-dev.cgjofbdf5rqg.eu-central-1.rds.amazonaws.com --dbdatabase xanadu2 --dbusr stefan --dbpwd XXXXXX --nameByTopic --disableValidation --defaultSrsCode 2056 --disableValidation --expandMultilingual --strokeArcs --createGeomIdx --createFkIdx --createEnumTabs --beautifyEnumDispName  --models Nutzungsplanung_LV95_V1_1 --dbschema npl_ch --export wisen_ch.xtf
```

```
xmllint --format wisen_ch.xtf -o wisen_ch.xtf
```

```
java -jar ~/Apps/ilivalidator-1.5.0/ilivalidator.jar wisen_ch.xtf
```



## Aggregationsinfrastruktur

Einmalig zuerst in AI konfigurieren. -> Screenshot.

```
curl -X POST -u XXXXXX:YYYYYY -F "topic=npl_nutzungsplanung" -F "lv95_file=@wisen_ch.xtf.zip" -F "publish=true" "https://integration.geodienste.ch/data_agg/interlis/import"
```

Zuerst in Integration (zusätzliches basic auth für admin seite: XXXXXX/YYYYYY):

WMS: https://integration.geodienste.ch/db/npl_nutzungsplanung/deu?