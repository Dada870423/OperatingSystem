#!/bin/sh
set -tx
if [ ! -d $HOME/.sa_dia ]; then
	mkdir $HOME/.sa_dia
	curl 'https://timetable.nctu.edu.tw/?r=main/get_cos_list' --data 'm_acy=107&m_sem=1&m_degree=3&m_dep_id=17&m_group=**&m_grade=**&m_class=**&m_option=**&m_crsname=**&m_teaname=**&m_cos_id=**&m_cos_code=**&m_crstime=**&m_crsoutline=**&m_costype=**' | tr '{' '\n' | tr '}' '\n' | tr ',' '\n' | grep cos_ename | awk -F ":" '{print NR, $2}' | sed -e 's/"//g' > $HOME/.sa_dia/cos_ename.txt

	
	curl 'https://timetable.nctu.edu.tw/?r=main/get_cos_list' --data 'm_acy=107&m_sem=1&m_degree=3&m_dep_id=17&m_group=**&m_grade=**&m_class=**&m_option=**&m_crsname=**&m_teaname=**&m_cos_id=**&m_cos_code=**&m_crstime=**&m_crsoutline=**&m_costype=**' | tr '{' '\n' | tr '}' '\n' | tr ',' '\n' | tr '-' ' ' | grep cos_time | sed -e 's/"//g' | tr ':' ' ' | awk  '{print NR, $2}' > $HOME/.sa_dia/cos_time.txt
#   # if the dir is not exist and then curl two files 
# and store tow txt	
	

	curl 'https://timetable.nctu.edu.tw/?r=main/get_cos_list' --data 'm_acy=107&m_sem=1&m_degree=3&m_dep_id=17&m_group=**&m_grade=**&m_class=**&m_option=**&m_crsname=**&m_teaname=**&m_cos_id=**&m_cos_code=**&m_crstime=**&m_crsoutline=**&m_costype=**' | tr '{' '\n' | tr '}' '\n' | tr ',' '\n' | tr '-' ' '  | grep cos_time  | tr ':' ' ' | awk  '{print  $2 , " ", $3}'  | sed -e 's/"//g' > $HOME/.sa_dia/new_time.txt



	


	paste -d ' ' $HOME/.sa_dia/cos_ename.txt $HOME/.sa_dia/new_time.txt > $HOME/.sa_dia/all.txt

echo "nono"
fi
welcome()
{
	dialog --ascii-lines --ok-label 'it time to play' --title 'it is not funny' --no-collapse --cr-wrap --msgbox '
/ ___|  / \  / ___|  / \  / ___|  / \
\___ \ / _ \ \___ \ / _ \ \___ \ / _ \
 ___) / ___ \ ___) / ___ \ ___) / ___ \
|____/_/   \_\____/_/   \_\____/_/   \_\



thanks fliget

' 16 50
show_style
}
show_style()
{
	exec 3>&1
	
	style_ar[0]="1 op1 Show Classroom"
	style_arr[1]="2 op2 Hide Extra Column"	
	
	sstyle=$(dialog --ascii-lines --clear --title "show style!!" --no-tags --menu "choose a course" 20 50 30  "${style_ar[@]}"  --output-fd 1);
	exec 3>&-
	echo "$sstyle";
	ttable
}
ttable()
{
	dialog --ascii-lines --clear --title "Time Table" --yesno "`cat $HOME/.sa_dia/timetable.txt`" 50 50
	respon=$?
	if [ "$respon" -eq 0 ]; then
		cblock
	else
		welcome
	fi
}
cblock()
{
	i=1;
	j=1;
	k=1;
	exec 3>&1
	num=0;
	
	arar=`cat $HOME/.sa_dia/all.txt | awk '{printf("%s",$0)}'`




#	while read inputfile; do
#		aarr+="$inputfile"
#	done < $HOME/.sa_dia/all.txt	
################################################### sall.txt need to implement in this code remember!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	cnum=$(dialog --ascii-lines --clear --title "class you can choose!!"  --no-items  --menu "choose a course" 20 50 30 $arar   --output-fd 1);
	

#	cat $HOME/.sa_dia/all.txt | grep -w $cnum >> $HOME/.sa_dia/chosen.txt
	#cho=`cat $HOME/.sa_dia/all.txt | grep  "$cnum" | awk '{print $0}'`
	#echo $cho >> $HOME/.sa_dia/chose.txt
	
	#echo $cho

	#echo $cnum
	#cat $HOME/.sa_dia/all.txt | awk '  {print $(cnum)} ' > $HOME/.sa_dia/uuu.txt


#	if [[ $cho =~ SA ]]; then
#		echo "good"
#	fi


	#cat $HOME/.sa_dia/all.txt | grep  -v "$cnum" > $HOME/.sa_dia/kkk.txt
	#cat $HOME/.sa_dia/kkk.txt > $HOME/.sa_dia/all.txt	


	exec 3>&-
}




welcome
