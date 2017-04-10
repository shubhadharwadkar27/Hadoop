USERS = LOAD '/home/shubha/Downloads/weblog' using PigStorage() as (user:chararray, gateway:chararray, time:float);
GATEWAYS = LOAD '/home/shubha/Downloads/gateway'using PigStorage() as (gateway:chararray, success_rate:float);
join1 = JOIN USERS by gateway, GATEWAYS by gateway;
--dump join1;
data1 = foreach join1 generate $0,$1,$4;
group1 = group data1 by $0;
--dump group1;
avg_user = foreach group1 generate group, AVG(data1.success_rate);
--dump avg_user;
final =filter avg_user by $1>90.00;
dump final;

