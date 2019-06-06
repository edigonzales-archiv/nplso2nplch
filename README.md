
## Kanton
```
java -jar ~/apps/ili2pg-4.1.0/ili2pg-4.1.0.jar --dbhost 192.168.50.2 --dbdatabase edit --dbschema arp_npl --dbusr ddluser --dbpwd ddluser --defaultSrsCode 2056 --strokeArcs --createGeomIdx --createFk --createFkIdx --createEnumTabs --beautifyEnumDispName --createMetaInfo --createUnique --createNumChecks --nameByTopic --disableValidation --models SO_Nutzungsplanung_20171118 --schemaimport
```

```
java -jar ~/apps/ili2pg-4.1.0/ili2pg-4.1.0.jar --dbhost 192.168.50.2 --dbdatabase edit --dbschema arp_npl --dbusr ddluser --dbpwd ddluser --defaultSrsCode 2056 --strokeArcs --createGeomIdx --createFk --createFkIdx --createEnumTabs --beautifyEnumDispName --createMetaInfo --createUnique --createNumChecks --nameByTopic --disableValidation --models SO_Nutzungsplanung_20171118 --import data/so/exp1_nplmes_20180906A.xtf
```

## Bund

### Nutzungsplanung
```
java -jar ~/apps/ili2pg-4.1.0/ili2pg-4.1.0.jar --dbhost 192.168.50.2 --dbdatabase edit --dbschema arp_npl_mgdm  --dbusr ddluser --dbpwd ddluser --defaultSrsCode 2056 --strokeArcs --createGeomIdx --createFk --createFkIdx --createEnumTabs --beautifyEnumDispName --createMetaInfo --createUnique --createNumChecks --nameByTopic --disableValidation --models "Nutzungsplanung_Hauptnutzung_V1_1;Nutzungsplanung_LV95_V1_1" --schemaimport
```

```
java -jar ~/apps/ili2pg-4.1.0/ili2pg-4.1.0.jar --dbhost 192.168.50.2 --dbdatabase edit --dbschema arp_npl_mgdm  --dbusr ddluser --dbpwd ddluser --defaultSrsCode 2056 --strokeArcs --createGeomIdx --createFk --createFkIdx --createEnumTabs --beautifyEnumDispName --createMetaInfo --createUnique --createNumChecks --nameByTopic --disableValidation --models Nutzungsplanung_Hauptnutzung_V1_1 --import data/ch/Hauptnutzung_CH_V1_1.xml
```

```
java -jar ~/apps/ili2pg-4.1.0/ili2pg-4.1.0.jar --dbhost 192.168.50.2 --dbdatabase edit --dbschema arp_npl_mgdm  --dbusr ddluser --dbpwd ddluser --defaultSrsCode 2056 --strokeArcs --createGeomIdx --createFk --createFkIdx --createEnumTabs --beautifyEnumDispName --createMetaInfo --createUnique --createNumChecks --nameByTopic --disableValidation --models Nutzungsplanung_LV95_V1_1 --export npl_ch.xtf
```

### Lärmempflindlichkeit
```
java -jar ~/apps/ili2pg-4.1.0/ili2pg-4.1.0.jar --dbhost 192.168.50.2 --dbdatabase edit --dbschema arp_laermempfindlichkeit_mgdm  --dbusr ddluser --dbpwd ddluser --defaultSrsCode 2056 --strokeArcs --createGeomIdx --createFk --createFkIdx --createEnumTabs --beautifyEnumDispName --createMetaInfo --createUnique --createNumChecks --nameByTopic --disableValidation --models Laermempfindlichkeitsstufen_LV95_V1_1 --schemaimport
```

```
java -jar ~/apps/ili2pg-4.1.0/ili2pg-4.1.0.jar --dbhost 192.168.50.2 --dbdatabase edit --dbschema arp_laermempfindlichkeit_mgdm  --dbusr ddluser --dbpwd ddluser --defaultSrsCode 2056 --strokeArcs --createGeomIdx --createFk --createFkIdx --createEnumTabs --beautifyEnumDispName --createMetaInfo --createUnique --createNumChecks --nameByTopic --models Laermempfindlichkeitsstufen_LV95_V1_1 --export laerm_ch.xtf
```