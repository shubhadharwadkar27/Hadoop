--book = load 'wordcount' using PigStorage() as (lines:chararray);
book = load '$input' using TextLoader as (lines:chararray);
--dump book;
transform = foreach book generate FLATTEN(TOKENIZE(lines)) as word;

--dump transform;

--transform =foreach transform generate TRIM(LOWER(REPLACE(word, ',' , '')) as word;
transform =foreach transform generate TRIM(LOWER(REPLACE(word, '[\\p{Punct},\\p{Cntrl}]',''))) as word;
transform = filter transform by word == '$myword';
--dump transform;
groupbyword = group transform by word;
--dump groupbyword;
--describe groupbyword;
countofeachword =foreach groupbyword generate group, COUNT(transform);
dump countofeachword;

