-- base view for the creation of DATASTREAMS
DROP MATERIALIZED VIEW sta.ce_dsbase cascade;

CREATE MATERIALIZED VIEW sta.ce_dsbase
AS SELECT ce.cdstationmesureeauxsurface,
ce.cdmethode,
ce.cdparametre,
ce.cdunitemesure,
min(ce.dateprel) AS mindateprel,
max(ce.dateprel) AS maxdateprel,
min(ce.heureparenv) AS minheureprel,
max(ce.heureparenv) AS maxheureprel
FROM physicochimie.condition_environnementale ce
WHERE NOT ce.cdprelevement is NULL
GROUP BY ce.cdstationmesureeauxsurface, ce.cdmethode, ce.cdparametre, ce.cdunitemesure;
-- base view for the creation of FEATURES
DROP MATERIALIZED VIEW sta.ce_foibase cascade;

CREATE MATERIALIZED VIEW sta.ce_foibase
AS SELECT ce.codeoperationcep, 
	min(ce.dateprel) AS mindateprel,
	max(ce.dateprel) AS maxdateprel,
	min(ce.heureparenv) AS minheureprel,
	max(ce.heureparenv) AS maxheureprel,
	ce.cdstationmesureeauxsurface
 FROM physicochimie.condition_environnementale ce
   WHERE NOT ce.cdprelevement is NULL
   GROUP BY ce.codeoperationcep, ce.dateprel, ce.cdstationmesureeauxsurface;
	
-- base view for the creation of SENSORS
DROP MATERIALIZED VIEW sta.ce_senbase cascade;

CREATE MATERIALIZED VIEW sta.ce_senbase
AS SELECT ce.cdmethode
   FROM physicochimie.condition_environnementale ce
   WHERE NOT ce.cdprelevement is NULL
  GROUP BY ce.cdmethode;
  
-- base view for the creation of OBS_PROPERTIES
DROP MATERIALIZED VIEW sta.ce_propbase cascade;

CREATE MATERIALIZED VIEW sta.ce_propbase
AS SELECT ce.cdparametre
   FROM physicochimie.condition_environnementale ce
   WHERE NOT ce.cdprelevement is NULL
GROUP BY ce.cdparametre;

-- base view for the creation of THINGS
DROP MATERIALIZED VIEW sta.ce_thgbase cascade;

CREATE MATERIALIZED VIEW sta.ce_thgbase
AS SELECT ce.cdstationmesureeauxsurface 
   FROM physicochimie.condition_environnementale ce
   WHERE NOT ce.cdprelevement is NULL
GROUP BY ce.cdstationmesureeauxsurface;  
