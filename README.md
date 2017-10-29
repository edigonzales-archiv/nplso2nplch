# nplso2nplch

```
java -jar ~/apps/ili2pg-3.9.1/ili2pg.jar --dbhost geodb-dev.cgjofbdf5rqg.eu-central-1.rds.amazonaws.com --dbdatabase xanadu2 --dbusr stefan --dbpwd XXXXXX --nameByTopic --disableValidation --defaultSrsCode 2056 --expandMultilingual --strokeArcs --createGeomIdx --createFkIdx --createEnumTabs --beautifyEnumDispName  --models "Nutzungsplanung_Hauptnutzung_V1_1;Nutzungsplanung_LV95_V1_1" --dbschema npl_ch --schemaimport
```

```
java -jar ~/apps/ili2pg-3.9.1/ili2pg.jar --dbhost geodb-dev.cgjofbdf5rqg.eu-central-1.rds.amazonaws.com --dbdatabase xanadu2 --dbusr stefan --dbpwd XXXXXX --nameByTopic --disableValidation --defaultSrsCode 2056 --expandMultilingual --strokeArcs --createGeomIdx --createFkIdx --createEnumTabs --beautifyEnumDispName  --models Nutzungsplanung_Hauptnutzung_V1_1 --dbschema npl_ch --import Hauptnutzung_CH_V1_1.xml
```


```
java -jar ~/apps/ili2pg-3.9.1/ili2pg.jar --dbhost geodb-dev.cgjofbdf5rqg.eu-central-1.rds.amazonaws.com --dbdatabase xanadu2 --dbusr stefan --dbpwd XXXXXX --nameByTopic --disableValidation --defaultSrsCode 2056 --strokeArcs --createGeomIdx --createFkIdx --createEnumTabs --beautifyEnumDispName  --models SO_Nutzungsplanung_20170915 --createBasketCol --createDatasetCol --dbschema npl_so --dataset 2502 --import exp1_wis_20170926_umbau.xtf
```





```
java -jar ~/apps/ili2pg-3.9.1/ili2pg.jar --dbhost geodb-dev.cgjofbdf5rqg.eu-central-1.rds.amazonaws.com --dbdatabase xanadu2 --dbusr stefan --dbpwd XXXXXX --nameByTopic --disableValidation --defaultSrsCode 2056 --disableValidation --expandMultilingual --strokeArcs --createGeomIdx --createFkIdx --createEnumTabs --beautifyEnumDispName  --models Nutzungsplanung_LV95_V1_1 --dbschema npl_ch --export wisen_ch.xtf
```

```
xmllint --format wisen_ch.xtf -o wisen_ch.xtf
```

```
java -jar ~/Apps/ilivalidator-1.5.0/ilivalidator.jar wisen_ch.xtf
```