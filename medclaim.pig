medical_data =load 'medical' using PigStorage('\t') as (name: chararray, dept: chararray, claim: double);
--dump medical_data;
groupbyname = group medical_data by name;
--groupbydept= group medical_data by dept;
--dump groupbyname;
--describe groupbyname;
--employee_claim =foreach groupbyname generate group as name, SUM(medical_data.claim), COUNT(medical_data) as totcount;
--dump employee_claim;
--avg_claim =foreach employee_claim generate $0, ROUND_TO(($1/$2),2);
avg_claim= foreach groupbyname generate group as name, ROUND_TO(AVG(medical_data.claim),2);
--avg_claim= foreach groupbydept generate group as dept, ROUND_TO(AVG(medical_data.claim),2);
dump avg_claim;
