--idx_person_name
CREATE INDEX if not EXISTS idx_person_name ON person (UPPER(name));

--DROP INDEX idx_person_name;

SET ENABLE_SEQSCAN TO OFF;

EXPLAIN ANALYZE 
SELECT * FROM person ORDER BY 1;

SET ENABLE_SEQSCAN TO ON;

