#!/bin/csh

set year = `date "+%Y"`
set month = ` date "+%m" ` 
set day = ` date "+%d" ` 

mail -s "[hw2]P76034711 呂鴻 $year/$month/$day" hunter0hunter04@hotmail.com.tw < ~/hw2/sum_log
mail -s "[hw2]P76034711 呂鴻 $year/$month/$day" hw.mike199250@gmail.com < ~/hw2/sum_log



