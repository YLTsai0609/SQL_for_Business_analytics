-- XXX :: convertion_dtype
-- https://blog.csdn.net/qq_35462323/article/details/121189454
SELECT '3.2'::numeric,
       '-123'::numeric,
       '1e3'::numeric,
       '1e-3'::numeric,
       '02314'::numeric,
       '0002'::numeric;