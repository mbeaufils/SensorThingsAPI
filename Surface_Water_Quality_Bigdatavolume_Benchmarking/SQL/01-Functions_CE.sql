-------------------------
---  sta.ce_foi_prop  ---
-------------------------

CREATE OR REPLACE FUNCTION sta.ce_foi_prop(dateprel date, heureprel time, datefinprel date, heurefinprel time, codecourseau text, libellecourseau text)
 RETURNS text
 LANGUAGE plpgsql
AS $function$
	DECLARE	
		outstr text;
	BEGIN
		outstr = '{';
		IF ((NOT dateprel ISNULL) OR (NOT datefinprel ISNULL)) 
			THEN
			outstr = outstr || '"phenomenonTime": { ';
			IF (NOT dateprel ISNULL) 
				THEN 
					outstr = outstr || '"startdate": "' || sta.make_time(dateprel, heureprel);
					outstr = outstr || '", "enddate": "' || sta.make_time(dateprel, heureprel);
			END IF;
			outstr = outstr || '"},'; 
		END IF;
		
		IF ((NOT codecourseau ISNULL) OR (NOT libellecourseau ISNULL)) 
			THEN 
				outstr = outstr || '"sampledFeature": {';
				IF (NOT codecourseau ISNULL) 
					THEN outstr = outstr || '"@id": "http://id.eaufrance.fr/mdo/' || codecourseau || '",'; END IF;
				IF ((NOT codecourseau ISNULL) OR (NOT libellecourseau ISNULL)) 
					THEN outstr = outstr || '"@type": "WFD:WaterBody"'; END IF;
				IF (NOT libellecourseau ISNULL) 
					THEN outstr = outstr || ', "name": "' || sta.clean(libellecourseau) || '"'; END IF;
				outstr = outstr || '},';
		END IF;		
		
		outstr = rtrim(outstr, ',') || '}';
		RETURN outstr;
	END
$function$
;

