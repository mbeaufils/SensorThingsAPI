-- Materialized View: sta."THINGS"
DROP MATERIALIZED VIEW sta."THINGS";

CREATE MATERIALIZED VIEW sta."THINGS" AS 
 SELECT sta.numeric_id_thing(stat.codestation) AS "ID",
    sta.clean(stat.libellestation) AS "DESCRIPTION",
    sta.thg_prop(stat.codestation) AS "PROPERTIES",
    sta.clean(stat.libellestation) AS "NAME"
FROM sta.thgbase base
   	left join referentiel_interne.station_full stat ON stat.codestation = base.cdstationmesureeauxsurface
WHERE base.cdstationmesureeauxsurface IS NOT NULL;

