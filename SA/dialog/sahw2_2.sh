#!/bin/sh
if [ ! -d $HOME/.sa_dia ]; then
	mkdir $HOME/.sa_dia
	mkdir $HOME/.sa_dia/day_class
	curl 'https://timetable.nctu.edu.tw/?r=main/get_cos_list' --data 'm_acy=107&m_sem=1&m_degree=3&m_dep_id=43&m_group=**&m_grade=**&m_class=**&m_option=**&m_crsname=**&m_teaname=**&m_cos_id=**&m_cos_code=**&m_crstime=**&m_crsoutline=**&m_costype=**' | tr '{' '\n' | tr '}' '\n' | tr ',' '\n' | grep cos_ename | awk -F ":" '{print  $2}' | sed -e 's/"//g' > $HOME/.sa_dia/cos_ename.txt

	
	curl 'https://timetable.nctu.edu.tw/?r=main/get_cos_list' --data 'm_acy=107&m_sem=1&m_degree=3&m_dep_id=43&m_group=**&m_grade=**&m_class=**&m_option=**&m_crsname=**&m_teaname=**&m_cos_id=**&m_cos_code=**&m_crstime=**&m_crsoutline=**&m_costype=**' | tr '{' '\n' | tr '}' '\n' | tr ',' '\n' | tr '-' ' ' | grep cos_time | sed -e 's/"//g' | tr ':' ' ' | awk  '{print $2}' > $HOME/.sa_dia/cos_nr_time.txt
#   # if the dir is not exist and then curl two files 
# and store tow txt	
	

	curl 'https://timetable.nctu.edu.tw/?r=main/get_cos_list' --data 'm_acy=107&m_sem=1&m_degree=3&m_dep_id=43&m_group=**&m_grade=**&m_class=**&m_option=**&m_crsname=**&m_teaname=**&m_cos_id=**&m_cos_code=**&m_crstime=**&m_crsoutline=**&m_costype=**' | tr '{' '\n' | tr '}' '\n' | tr ',' '\n' | tr '-' ' '  | grep cos_time  | tr ':' ' ' | awk  '{print  $2 , " ", $3}'  | sed -e 's/"//g' > $HOME/.sa_dia/time_room.txt


	curl 'https://timetable.nctu.edu.tw/?r=main/get_cos_list' --data 'm_acy=107&m_sem=1&m_degree=3&m_dep_id=43&m_group=**&m_grade=**&m_class=**&m_option=**&m_crsname=**&m_teaname=**&m_cos_id=**&m_cos_code=**&m_crstime=**&m_crsoutline=**&m_costype=**' | tr '{' '\n' | tr '}' '\n' | tr ',' '\n' | tr '-' ' '  | grep cos_time  | tr ':' ' ' | awk  '{print  $2 , " ", $3}'  | sed -e 's/"//g' | awk '{print $2}' > $HOME/.sa_dia/out_time_room.txt

	


	paste -d ' ' $HOME/.sa_dia/cos_ename.txt $HOME/.sa_dia/time_room.txt > $HOME/.sa_dia/all_space.txt
	cat $HOME/.sa_dia/cos_ename.txt | tr ' ' '_' | awk '{print NR, $0 }' > $HOME/.sa_dia/op2.txt
	cat $HOME/.sa_dia/all_space.txt | tr ' ' '_' | awk '{print $0 }' > $HOME/.sa_dia/a_ll.txt
	cat $HOME/.sa_dia/all_space.txt | tr ' ' '_' | awk '{print NR, $0 }' > $HOME/.sa_dia/a_ll_NR.txt
	cat $HOME/.sa_dia/all_space.txt | awk '{print NR," ",$0}' >	$HOME/.sa_dia/all_NR_space.txt

	paste -d ' ' $HOME/.sa_dia/cos_ename.txt $HOME/.sa_dia/out_time_room.txt> $HOME/.sa_dia/out_all_space.txt
	cat $HOME/.sa_dia/out_all_space.txt | tr ' ' '_' | awk '{print NR, $0 }' > $HOME/.sa_dia/out_a_ll.txt

	



	cat $HOME/.sa_dia/all_space.txt | tr ' ' '_' | awk '{print NR, $0, " off\\" }' > $HOME/.sa_dia/a_ll_bui.txt
	cat $HOME/.sa_dia/all_space.txt | tr ' ' '_' | awk '{print NR, $0, " off\\" }' > $HOME/.sa_dia/for_bui_not_change.txt


	cat $HOME/.sa_dia/cos_nr_time.txt | sed -e 's/\([1-7][A-Z][A-Z]*\).*/\1/g' > $HOME/.sa_dia/first.txt
	cat $HOME/.sa_dia/cos_nr_time.txt | sed -e 's/\([1-7][A-Z][A-Z]*\)//' > $HOME/.sa_dia/tmp.txt
	cat $HOME/.sa_dia/tmp.txt | sed -e 's/\([1-7][A-Z][A-Z]*\).*/\1/g' > $HOME/.sa_dia/second.txt
	cat $HOME/.sa_dia/tmp.txt | sed -e 's/\([1-7][A-Z][A-Z]*\)//' > $HOME/.sa_dia/third.txt

	paste -d ' ' $HOME/.sa_dia/first.txt $HOME/.sa_dia/second.txt > $HOME/.sa_dia/time_split.txt
	paste -d ' ' $HOME/.sa_dia/time_split.txt $HOME/.sa_dia/third.txt > $HOME/.sa_dia/tmp.txt
	cat $HOME/.sa_dia/tmp.txt | awk '{print NR, $0}' > $HOME/.sa_dia/time_NR_split.txt
	cat $HOME/.sa_dia/tmp.txt | awk '{print $0}' > $HOME/.sa_dia/time_split.txt

	echo ".x. .x. .x. .x. .x. .x." >  $HOME/.sa_dia/day_class/N.txt 
	echo ".x. .x. .x. .x. .x. .x." >  $HOME/.sa_dia/day_class/A.txt 
	echo ".x. .x. .x. .x. .x. .x." >  $HOME/.sa_dia/day_class/B.txt 
	echo ".x. .x. .x. .x. .x. .x." >  $HOME/.sa_dia/day_class/C.txt 
	echo ".x. .x. .x. .x. .x. .x." >  $HOME/.sa_dia/day_class/D.txt 
	echo ".x. .x. .x. .x. .x. .x." >  $HOME/.sa_dia/day_class/X.txt 
	echo ".x. .x. .x. .x. .x. .x." >  $HOME/.sa_dia/day_class/E.txt 
	echo ".x. .x. .x. .x. .x. .x." >  $HOME/.sa_dia/day_class/F.txt 
	echo ".x. .x. .x. .x. .x. .x." >  $HOME/.sa_dia/day_class/G.txt 
	echo ".x. .x. .x. .x. .x. .x." >  $HOME/.sa_dia/day_class/H.txt 
	echo ".x. .x. .x. .x. .x. .x." >  $HOME/.sa_dia/day_class/Y.txt 
	echo ".x. .x. .x. .x. .x. .x." >  $HOME/.sa_dia/day_class/I.txt 
	echo ".x. .x. .x. .x. .x. .x." >  $HOME/.sa_dia/day_class/J.txt 
	echo ".x. .x. .x. .x. .x. .x." >  $HOME/.sa_dia/day_class/K.txt 
	
	cat $HOME/.sa_dia/day_class/N.txt > $HOME/.sa_dia/ttb.txt
	cat $HOME/.sa_dia/day_class/A.txt >> $HOME/.sa_dia/ttb.txt
	cat $HOME/.sa_dia/day_class/B.txt >> $HOME/.sa_dia/ttb.txt
	cat $HOME/.sa_dia/day_class/C.txt >> $HOME/.sa_dia/ttb.txt
	cat $HOME/.sa_dia/day_class/D.txt >> $HOME/.sa_dia/ttb.txt
	cat $HOME/.sa_dia/day_class/X.txt >> $HOME/.sa_dia/ttb.txt
	cat $HOME/.sa_dia/day_class/E.txt >> $HOME/.sa_dia/ttb.txt
	cat $HOME/.sa_dia/day_class/F.txt >> $HOME/.sa_dia/ttb.txt
	cat $HOME/.sa_dia/day_class/G.txt >> $HOME/.sa_dia/ttb.txt
	cat $HOME/.sa_dia/day_class/H.txt >> $HOME/.sa_dia/ttb.txt
	cat $HOME/.sa_dia/day_class/Y.txt >> $HOME/.sa_dia/ttb.txt
	cat $HOME/.sa_dia/day_class/I.txt >> $HOME/.sa_dia/ttb.txt
	cat $HOME/.sa_dia/day_class/J.txt >> $HOME/.sa_dia/ttb.txt
	cat $HOME/.sa_dia/day_class/K.txt >> $HOME/.sa_dia/ttb.txt

	cat $HOME/.sa_dia/ttb.txt | column -tx > $HOME/.sa_dia/output_op1.txt

	echo -n "" > $HOME/.sa_dia/1.txt
	echo -n "" > $HOME/.sa_dia/2.txt
	echo -n "" > $HOME/.sa_dia/3.txt
	echo -n "" > $HOME/.sa_dia/4.txt
	echo -n "" > $HOME/.sa_dia/5.txt

	echo -n "" > $HOME/.sa_dia/chosen.txt



#echo "nono"
fi
welcome()
{
	dialog --ascii-lines --ok-label 'it time to play' --title 'it is not funny' --no-collapse --cr-wrap --msgbox '
/ ___|  / \  / ___|  / \  / ___|  / \
\___ \ / _ \ \___ \ / _ \ \___ \ / _ \
 ___) / ___ \ ___) / ___ \ ___) / ___ \
|____/_/   \_\____/_/   \_\____/_/   \_\



by dada

' 16 50
sstyle="1"
ttable
}
show_style()
{
	#exec 3>&1
	style_ar0="1 op1_Show_Classroom"
	style_ar1="2 op2_Show_Extra_Column"	
	sstyle=$(dialog --ascii-lines --clear --title "show style!!" --no-tags  --menu "choose a course" 20 50 50 "1" "$style_ar0" "2" "$style_ar1"  --output-fd 1);
	#echo "$sstyle"
	#exec 3>&-
	#echo "$sstyle";
	ttable	
}
ttable()
{
#	dialog --ascii-lines --clear --title "Time Table" --yesno "`cat $HOME/.sa_dia/timetable.txt`" 50 50
	if [ "$sstyle" == "1" ]; then
		dialog --title "this is your time table!!" \
		--extra-button --ok-label "ADD" \
		--extra-label "option" \
		--cancel-label "Exit" \
		--no-collapse \
		--yesno "`cat $HOME/.sa_dia/output_op2.txt`" 16 160
		respon=$?
		if [ "$respon" -eq 0 ]; then
			cblock
		elif [ "$respon" -eq 1 ]; then
			Exit
		elif [ "$respon" -eq 3 ]; then
			show_style
		fi
	elif [ "$sstyle" == "2" ]; then
		dialog --title "this is your time table!!" \
		--extra-button --ok-label "ADD" \
		--extra-label "option" \
		--cancel-label "Exit" \
		--no-collapse \
		--yesno "`cat $HOME/.sa_dia/output_op1.txt`" 40 200
		respon=$?
		if [ "$respon" -eq 0 ]; then
			cblock
		elif [ "$respon" -eq 1 ]; then
			Exit
		elif [ "$respon" -eq 3 ]; then
			show_style
		fi
			
	fi
	
}
Exit()
{
	dialog --ascii-lines --ok-label 'Bye Bye' --title '881 881 881 ' --no-collapse --cr-wrap --msgbox '
 ______   _______   ______   _______ 
| __ ) \ / / ____| | __ ) \ / / ____|
|  _ \\ V /|  _|   |  _ \\ V /|  _|  
| |_) || | | |___  | |_) || | | |___ 
|____/ |_| |_____| |____/ |_| |_____|



thanks figlet

' 16 50
}
cblock()
{
	i=1;
	j=1;
	k=1;
	exec 3>&1
	num=0;

	#str=`cat $HOME/.sa_dia/a_ll.txt|awk 'BEGIN{t=1;}{printf("%d \"%s\" ",t++,$0)}'`

	

	dialog --buildlist  "course" 150 60 60 `cat $HOME/.sa_dia/a_ll_bui.txt` 2>$HOME/.sa_dia/bui.txt
	res=$?
	#echo "$res"
	if [ "$res" -ne "0" ]; then
		welcome
	else
		####start to check collition

		new_class=`cat $HOME/.sa_dia/bui.txt`
		ttime=`cat $HOME/.sa_dia/time_NR_split.txt`
		echo "new class: "
		#echo "$new_class"

		echo -n "" > $HOME/.sa_dia/tmp_time.txt
		#$HOME/.sa_dia/tmp_time.txt < /dev/null	
		#echo "new_class: "
		#echo "$new_class"

		for i in $new_class
		do
			echo "$ttime" | grep -w "$i" | awk '{printf "%s\n",substr($0,index($0,$2)); }' > $HOME/.sa_dia/tmp.txt

			paste -d ' ' $HOME/.sa_dia/tmp_time.txt $HOME/.sa_dia/tmp.txt > $HOME/.sa_dia/tmp_1.txt
			cat $HOME/.sa_dia/tmp_1.txt > $HOME/.sa_dia/tmp_time.txt
		done


		###initialize
		echo -n "" > $HOME/.sa_dia/.1.txt
		echo -n "" > $HOME/.sa_dia/.2.txt 
		echo -n "" > $HOME/.sa_dia/.3.txt
		echo -n "" > $HOME/.sa_dia/.4.txt 
		echo -n "" > $HOME/.sa_dia/.5.txt
		flag="0"
		###init end

		time_check_insert=`cat $HOME/.sa_dia/tmp_1.txt`

		for i in $time_check_insert
		do
			#echo "$i"
			num=`echo "$i" | wc -L`
			dd=`echo "$i" | head -c 1 | tail -c 1`
			#############################################length=2
			if [ $num -eq "2" ]; then 
				tt=`echo "$i" | head -c 2 | tail -c 1`  ##### 1
				if [ $dd -eq "1" ]; then
					check=`cat $HOME/.sa_dia/.1.txt | grep "$tt"` #mon
					#echo $check
					if [  ${#check} -eq 0 ]; then
						echo $tt >> $HOME/.sa_dia/.1.txt
						#echo "nono"
					else
						flag="1"
					fi
				fi

				if [ $dd -eq "2" ]; then
					check=`cat $HOME/.sa_dia/.2.txt | grep "$tt"` #tue
					#echo $check
					if [  ${#check} -eq 0 ]; then
						echo $tt >> $HOME/.sa_dia/.2.txt
					else
						flag="1"
					fi
				fi
				if [ $dd -eq "3" ]; then
					check=`cat $HOME/.sa_dia/.3.txt | grep "$tt"` #wed
					#echo $check
					if [  ${#check} -eq 0 ]; then
						echo $tt >> $HOME/.sa_dia/.3.txt
					else
						flag="1"
					fi
				fi
				if [ $dd -eq "4" ]; then
					check=`cat $HOME/.sa_dia/.4.txt | grep "$tt"` #thu
					#echo $check
					if [  ${#check} -eq 0 ]; then
						echo $tt >> $HOME/.sa_dia/.4.txt
					else
						flag="1"
					fi
				fi
				if [ $dd -eq "5" ]; then
					check=`cat $HOME/.sa_dia/.5.txt | grep "$tt"` #fri
					#echo $check
					if [  ${#check} -eq 0 ]; then
						echo $tt >> $HOME/.sa_dia/.5.txt
					else
						flag="1"
					fi
				fi


			fi
			#############################################length=3

			if [ $num -eq "3" ]; then 
				tt=`echo "$i" | head -c 2 | tail -c 1`  ##### 1
				if [ $dd -eq "1" ]; then
					check=`cat $HOME/.sa_dia/.1.txt | grep "$tt"` #mon
					#echo $check
					if [  ${#check} -eq 0 ]; then
						echo $tt >> $HOME/.sa_dia/.1.txt
						#echo "nono"
					else
						flag="1"
						echo "mon_yes"
					fi
				fi

				if [ $dd -eq "2" ]; then
					check=`cat $HOME/.sa_dia/.2.txt | grep "$tt"` #tue
					#echo $check
					if [  ${#check} -eq 0 ]; then
						echo $tt >> $HOME/.sa_dia/.2.txt
					else
						flag="1"
					fi
				fi
				if [ $dd -eq "3" ]; then
					check=`cat $HOME/.sa_dia/.3.txt | grep "$tt"` #wed
					#echo $check
					if [  ${#check} -eq 0 ]; then
						echo $tt >> $HOME/.sa_dia/.3.txt
					else
						flag="1"
					fi
				fi
				if [ $dd -eq "4" ]; then
					check=`cat $HOME/.sa_dia/.4.txt | grep "$tt"` #thu
					#echo $check
					if [  ${#check} -eq 0 ]; then
						echo $tt >> $HOME/.sa_dia/.4.txt
						#echo "nono"
					else
						flag="1"
						echo "thu_yes"
					fi
				fi
				if [ $dd -eq "5" ]; then
					check=`cat $HOME/.sa_dia/.5.txt | grep "$tt"` #fri
					#echo $check
					if [  ${#check} -eq 0 ]; then
						echo $tt >> $HOME/.sa_dia/.5.txt
					else
						flag="1"
					fi
				fi

				tt=`echo "$i" | head -c 3 | tail -c 1`  ##### 2
				if [ $dd -eq "1" ]; then
					check=`cat $HOME/.sa_dia/.1.txt | grep "$tt"` #mon
					#echo $check
					if [  ${#check} -eq 0 ]; then
						echo $tt >> $HOME/.sa_dia/.1.txt
					else
						flag="1"
					fi
				fi

				if [ $dd -eq "2" ]; then
					check=`cat $HOME/.sa_dia/.2.txt | grep "$tt"` #tue
					#echo $check
						if [  ${#check} -eq 0 ]; then
						echo $tt >> $HOME/.sa_dia/.2.txt
					else
						flag="1"
					fi
				fi
				if [ $dd -eq "3" ]; then
					check=`cat $HOME/.sa_dia/.3.txt | grep "$tt"` #wed
					#echo $check
					if [  ${#check} -eq 0 ]; then
						echo $tt >> $HOME/.sa_dia/.3.txt
					else
						flag="1"
					fi
				fi
				if [ $dd -eq "4" ]; then
					check=`cat $HOME/.sa_dia/.4.txt | grep "$tt"` #thu
					#echo $check
					if [  ${#check} -eq 0 ]; then
						echo $tt >> $HOME/.sa_dia/.4.txt
					else
						flag="1"
					fi
				fi
				if [ $dd -eq "5" ]; then
					check=`cat $HOME/.sa_dia/.5.txt | grep "$tt"` #fri
					#echo $check
					if [  ${#check} -eq 0 ]; then
						echo $tt >> $HOME/.sa_dia/.5.txt
					else
						flag="1"
					fi
				fi

			fi
			#############################################length=3
			if [ $num -eq "4" ]; then 
				tt=`echo "$i" | head -c 2 | tail -c 1`  ##### 1
				if [ $dd -eq "1" ]; then
					check=`cat $HOME/.sa_dia/.1.txt | grep "$tt"` #mon
					#echo $check
					if [  ${#check} -eq 0 ]; then
						echo $tt >> $HOME/.sa_dia/.1.txt
					else
						flag="1"
					fi
				fi

				if [ $dd -eq "2" ]; then
					check=`cat $HOME/.sa_dia/.2.txt | grep "$tt"` #tue
					#echo $check
					if [  ${#check} -eq 0 ]; then
						echo $tt >> $HOME/.sa_dia/.2.txt
					else
						flag="1"
					fi
				fi
				if [ $dd -eq "3" ]; then
					check=`cat $HOME/.sa_dia/.3.txt | grep "$tt"` #wed
					#echo $check
					if [  ${#check} -eq 0 ]; then
						echo $tt >> $HOME/.sa_dia/.3.txt
					else
						flag="1"
					fi
				fi
				if [ $dd -eq "4" ]; then
					check=`cat $HOME/.sa_dia/.4.txt | grep "$tt"` #thu
					#echo $check
					if [  ${#check} -eq 0 ]; then
						echo $tt >> $HOME/.sa_dia/.4.txt
					else	
						flag="1"
					fi
				fi
				if [ $dd -eq "5" ]; then
					check=`cat $HOME/.sa_dia/.5.txt | grep "$tt"` #fri
					#echo $check
					if [  ${#check} -eq 0 ]; then
						echo $tt >> $HOME/.sa_dia/.5.txt
					else
						flag="1"
					fi
				fi

				tt=`echo "$i" | head -c 3 | tail -c 1`  ##### 2
				if [ $dd -eq "1" ]; then
					check=`cat $HOME/.sa_dia/.1.txt | grep "$tt"` #mon
					#echo $check
					if [  ${#check} -eq 0 ]; then
						echo $tt >> $HOME/.sa_dia/.1.txt
					else
						flag="1"
					fi
				fi

				if [ $dd -eq "2" ]; then
					check=`cat $HOME/.sa_dia/.2.txt | grep "$tt"` #tue
					#echo $check
					if [  ${#check} -eq 0 ]; then
						echo $tt >> $HOME/.sa_dia/.2.txt
					else
						flag="1"
					fi
				fi
				if [ $dd -eq "3" ]; then
					check=`cat $HOME/.sa_dia/.3.txt | grep "$tt"` #wed
					#echo $check
					if [  ${#check} -eq 0 ]; then
						echo $tt >> $HOME/.sa_dia/.3.txt
					else
						flag="1"
					fi
				fi
				if [ $dd -eq "4" ]; then
					check=`cat $HOME/.sa_dia/.4.txt | grep "$tt"` #thu
					#echo $check
					if [  ${#check} -eq 0 ]; then
						echo $tt >> $HOME/.sa_dia/.4.txt
					else
						flag="1"
					fi
				fi
				if [ $dd -eq "5" ]; then
					check=`cat $HOME/.sa_dia/.5.txt | grep "$tt"` #fri
					#echo $check
					if [  ${#check} -eq 0 ]; then
						echo $tt >> $HOME/.sa_dia/.5.txt
					else
						flag="1"
					fi
				fi

				tt=`echo "$i" | head -c 4 | tail -c 1`  ##### 3
				if [ $dd -eq "1" ]; then
					check=`cat $HOME/.sa_dia/.1.txt | grep "$tt"` #mon
					#echo $check
					if [  ${#check} -eq 0 ]; then
						echo $tt >> $HOME/.sa_dia/.1.txt
					else
						flag="1"
					fi
				fi

				if [ $dd -eq "2" ]; then
					check=`cat $HOME/.sa_dia/.2.txt | grep "$tt"` #tue
					#echo $check
					if [  ${#check} -eq 0 ]; then
						echo $tt >> $HOME/.sa_dia/.2.txt
					else	
						flag="1"
					fi
				fi
				if [ $dd -eq "3" ]; then
					check=`cat $HOME/.sa_dia/.3.txt | grep "$tt"` #wed
					#echo $check
					if [  ${#check} -eq 0 ]; then
						echo $tt >> $HOME/.sa_dia/.3.txt
					else
						flag="1"
					fi
				fi
				if [ $dd -eq "4" ]; then
					check=`cat $HOME/.sa_dia/.4.txt | grep "$tt"` #thu
					if [  ${#check} -eq 0 ]; then
						echo $tt >> $HOME/.sa_dia/.4.txt
					else
						flag="1"
					fi
				fi
				if [ $dd -eq "5" ]; then
					check=`cat $HOME/.sa_dia/.5.txt | grep "$tt"` #fri
					if [  ${#check} -eq 0 ]; then
						echo $tt >> $HOME/.sa_dia/.5.txt
					else
						flag="1"
					fi
				fi


			fi
			############################################# tmp_insert_done
		done

		exec 3>&-
		if [ $flag -eq "1" ]; then
			dialog --ascii-lines --ok-label 'Go Back' --title 'You are conflict ' --no-collapse --cr-wrap --msgbox '
			 ____                      _         _         _   _           _   
			|  _ \  ___    _ __   ___ | |_    __| | ___   | |_| |__   __ _| |_ 
			| | | |/ _ \  |  _ \ / _ \| __|  / _  |/ _ \  | __|  _ \ / _  | __|
			| |_| | (_) | | | | | (_) | |_  | (_| | (_) | | |_| | | | (_| | |_ 
			|____/ \___/  |_| |_|\___/ \__|  \__,_|\___/   \__|_| |_|\__,_|\__|

			NoNo

			' 16 120
			cblock
		else
			cat $HOME/.sa_dia/.1.txt > $HOME/.sa_dia/1.txt
			cat $HOME/.sa_dia/.2.txt > $HOME/.sa_dia/2.txt
			cat $HOME/.sa_dia/.3.txt > $HOME/.sa_dia/3.txt
			cat $HOME/.sa_dia/.4.txt > $HOME/.sa_dia/4.txt
			cat $HOME/.sa_dia/.5.txt > $HOME/.sa_dia/5.txt
			#cat $HOME/.sa_dia/bui.txt
			cat $HOME/.sa_dia/bui.txt > $HOME/.sa_dia/chosen.txt
			change_the_build_list
		fi
			
		
		#echo $str
		#maxx=$(dialog --title "class you can choose!!" --no-tags   --menu "choose a course" 20 50 30 `echo $str` --output-fd 1);
		#if [ $? -eq "0" ]; then
		#	echo "$maxx"
		#	conflict
		#else
		#	welcome
		#fi
	fi


	
	
}

##=============================================================================================================##################
change_the_build_list()
{
	echo -n "" > $HOME/.sa_dia/tmplplp.txt
	new_class=`cat $HOME/.sa_dia/chosen.txt`
	cat $HOME/.sa_dia/for_bui_not_change.txt > $HOME/.sa_dia/nn.txt
	for i in $new_class
	do
		cat $HOME/.sa_dia/nn.txt | grep -w "$i" | awk ' { print $1, $2, " on" } ' >> $HOME/.sa_dia/tmplplp.txt
		#cat $HOME/.sa_dia/tmplplp.txt >> $HOME/.sa_dia/a_ll_bui.txt
		cat $HOME/.sa_dia/nn.txt | grep -wv "$i" | awk ' { print $0 }' > $HOME/.sa_dia/tmp.txt
		cat $HOME/.sa_dia/tmp.txt > $HOME/.sa_dia/nn.txt
	done
	cat $HOME/.sa_dia/tmplplp.txt >> $HOME/.sa_dia/nn.txt
	cat $HOME/.sa_dia/nn.txt > $HOME/.sa_dia/a_ll_bui.txt
	#cat $HOME/.sa_dia/tmplplp.txt
	insert_pre_correct_table
}

##=============================================================================================================##################
insert_pre_correct_table()
{
	#######ini
	echo ".x. .x. .x. .x. .x. .x." >  $HOME/.sa_dia/day_class/N.txt 
	echo ".x. .x. .x. .x. .x. .x." >  $HOME/.sa_dia/day_class/A.txt 
	echo ".x. .x. .x. .x. .x. .x." >  $HOME/.sa_dia/day_class/B.txt 
	echo ".x. .x. .x. .x. .x. .x." >  $HOME/.sa_dia/day_class/C.txt 
	echo ".x. .x. .x. .x. .x. .x." >  $HOME/.sa_dia/day_class/D.txt 
	echo ".x. .x. .x. .x. .x. .x." >  $HOME/.sa_dia/day_class/X.txt 
	echo ".x. .x. .x. .x. .x. .x." >  $HOME/.sa_dia/day_class/E.txt 
	echo ".x. .x. .x. .x. .x. .x." >  $HOME/.sa_dia/day_class/F.txt 
	echo ".x. .x. .x. .x. .x. .x." >  $HOME/.sa_dia/day_class/G.txt 
	echo ".x. .x. .x. .x. .x. .x." >  $HOME/.sa_dia/day_class/H.txt 
	echo ".x. .x. .x. .x. .x. .x." >  $HOME/.sa_dia/day_class/Y.txt 
	echo ".x. .x. .x. .x. .x. .x." >  $HOME/.sa_dia/day_class/I.txt 
	echo ".x. .x. .x. .x. .x. .x." >  $HOME/.sa_dia/day_class/J.txt 
	echo ".x. .x. .x. .x. .x. .x." >  $HOME/.sa_dia/day_class/K.txt
	#######ini_end
	new_class=`cat $HOME/.sa_dia/chosen.txt`
	ttime=`cat $HOME/.sa_dia/time_NR_split.txt`
	
	for i in $new_class ########################################################################## nightmare begin
	do
		#echo "$i"
		cclass_room=`cat $HOME/.sa_dia/out_a_ll.txt | grep -w "$i" | awk '{printf "%s\n",substr($0,index($0,$2)); }'`
		ttime=`cat $HOME/.sa_dia/time_NR_split.txt | grep -w "$i" | awk '{printf "%s\n",substr($0,index($0,$2)); }'`
		for j in $ttime
		do 
			num=`echo "$j" | wc -L`
			dd=`echo "$j" | head -c 1 | tail -c 1`  ##day
			if [ $num -eq "2" ]; then 
				tt=`echo "$j" | head -c 2 | tail -c 1` ##time
				if [ $tt == "N" ]; then
					if [ $dd -eq "1" ]; then
						cat $HOME/.sa_dia/day_class/N.txt | awk -v cc=$cclass_room '{print cc,$2,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/N.txt
					fi
					if [ $dd -eq "2" ]; then
						cat $HOME/.sa_dia/day_class/N.txt | awk -v cc=$cclass_room '{print $1,cc,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/N.txt
					fi
					if [ $dd -eq "3" ]; then
						cat $HOME/.sa_dia/day_class/N.txt | awk -v cc=$cclass_room '{print $1,$2,cc,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/N.txt
					fi
					if [ $dd -eq "4" ]; then
						cat $HOME/.sa_dia/day_class/N.txt | awk -v cc=$cclass_room '{print $1,$2,$3,cc,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/N.txt
					fi
					if [ $dd -eq "5" ]; then
						cat $HOME/.sa_dia/day_class/N.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,cc,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/N.txt
					fi
					if [ $dd -eq "6" ]; then
						cat $HOME/.sa_dia/day_class/N.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,$5,cc}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/N.txt
					fi
				fi

				if [ $tt == "A" ]; then
					if [ $dd -eq "1" ]; then
						cat $HOME/.sa_dia/day_class/A.txt | awk -v cc=$cclass_room '{print cc,$2,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/A.txt
					fi
					if [ $dd -eq "2" ]; then
						cat $HOME/.sa_dia/day_class/A.txt | awk -v cc=$cclass_room '{print $1,cc,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/A.txt
					fi
					if [ $dd -eq "3" ]; then
						cat $HOME/.sa_dia/day_class/A.txt | awk -v cc=$cclass_room '{print $1,$2,cc,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/A.txt
					fi
					if [ $dd -eq "4" ]; then
						cat $HOME/.sa_dia/day_class/A.txt | awk -v cc=$cclass_room '{print $1,$2,$3,cc,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/A.txt
					fi
					if [ $dd -eq "5" ]; then
						cat $HOME/.sa_dia/day_class/A.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,cc,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/A.txt
					fi
					if [ $dd -eq "6" ]; then
						cat $HOME/.sa_dia/day_class/A.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,$5,cc}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/A.txt
					fi
				fi

				if [ $tt == "B" ]; then
					if [ $dd -eq "1" ]; then
						cat $HOME/.sa_dia/day_class/B.txt | awk -v cc=$cclass_room '{print cc,$2,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/B.txt
					fi
					if [ $dd -eq "2" ]; then
						cat $HOME/.sa_dia/day_class/B.txt | awk -v cc=$cclass_room '{print $1,cc,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/B.txt
					fi
					if [ $dd -eq "3" ]; then
						cat $HOME/.sa_dia/day_class/B.txt | awk -v cc=$cclass_room '{print $1,$2,cc,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/B.txt
					fi
					if [ $dd -eq "4" ]; then
						cat $HOME/.sa_dia/day_class/B.txt | awk -v cc=$cclass_room '{print $1,$2,$3,cc,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/B.txt
					fi
					if [ $dd -eq "5" ]; then
						cat $HOME/.sa_dia/day_class/B.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,cc,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/B.txt
					fi
					if [ $dd -eq "6" ]; then
						cat $HOME/.sa_dia/day_class/B.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,$5,cc}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/B.txt
					fi
				fi

				if [ $tt == "C" ]; then
					if [ $dd -eq "1" ]; then
						cat $HOME/.sa_dia/day_class/C.txt | awk -v cc=$cclass_room '{print cc,$2,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/C.txt
					fi
					if [ $dd -eq "2" ]; then
						cat $HOME/.sa_dia/day_class/C.txt | awk -v cc=$cclass_room '{print $1,cc,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/C.txt
					fi
					if [ $dd -eq "3" ]; then
						cat $HOME/.sa_dia/day_class/C.txt | awk -v cc=$cclass_room '{print $1,$2,cc,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/C.txt
					fi
					if [ $dd -eq "4" ]; then
						cat $HOME/.sa_dia/day_class/C.txt | awk -v cc=$cclass_room '{print $1,$2,$3,cc,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/C.txt
					fi
					if [ $dd -eq "5" ]; then
						cat $HOME/.sa_dia/day_class/C.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,cc,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/C.txt
					fi
					if [ $dd -eq "6" ]; then
						cat $HOME/.sa_dia/day_class/C.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,$5,cc}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/C.txt
					fi
				fi

				if [ $tt == "D" ]; then
					if [ $dd -eq "1" ]; then
						cat $HOME/.sa_dia/day_class/D.txt | awk -v cc=$cclass_room '{print cc,$2,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/D.txt
					fi
					if [ $dd -eq "2" ]; then
						cat $HOME/.sa_dia/day_class/D.txt | awk -v cc=$cclass_room '{print $1,cc,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/D.txt
					fi
					if [ $dd -eq "3" ]; then
						cat $HOME/.sa_dia/day_class/D.txt | awk -v cc=$cclass_room '{print $1,$2,cc,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/D.txt
					fi
					if [ $dd -eq "4" ]; then
						cat $HOME/.sa_dia/day_class/D.txt | awk -v cc=$cclass_room '{print $1,$2,$3,cc,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/D.txt
					fi
					if [ $dd -eq "5" ]; then
						cat $HOME/.sa_dia/day_class/D.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,cc,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/D.txt
					fi
					if [ $dd -eq "6" ]; then
						cat $HOME/.sa_dia/day_class/D.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,$5,cc}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/D.txt
					fi
				fi

				if [ $tt == "X" ]; then
					if [ $dd -eq "1" ]; then
						cat $HOME/.sa_dia/day_class/X.txt | awk -v cc=$cclass_room '{print cc,$2,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/X.txt
					fi
					if [ $dd -eq "2" ]; then
						cat $HOME/.sa_dia/day_class/X.txt | awk -v cc=$cclass_room '{print $1,cc,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/X.txt
					fi
					if [ $dd -eq "3" ]; then
						cat $HOME/.sa_dia/day_class/X.txt | awk -v cc=$cclass_room '{print $1,$2,cc,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/X.txt
					fi
					if [ $dd -eq "4" ]; then
						cat $HOME/.sa_dia/day_class/X.txt | awk -v cc=$cclass_room '{print $1,$2,$3,cc,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/X.txt
					fi
					if [ $dd -eq "5" ]; then
						cat $HOME/.sa_dia/day_class/X.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,cc,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/X.txt
					fi
					if [ $dd -eq "6" ]; then
						cat $HOME/.sa_dia/day_class/X.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,$5,cc}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/X.txt
					fi
				fi

				if [ $tt == "E" ]; then
					if [ $dd -eq "1" ]; then
						cat $HOME/.sa_dia/day_class/E.txt | awk -v cc=$cclass_room '{print cc,$2,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/E.txt
					fi
					if [ $dd -eq "2" ]; then
						cat $HOME/.sa_dia/day_class/E.txt | awk -v cc=$cclass_room '{print $1,cc,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/E.txt
					fi
					if [ $dd -eq "3" ]; then
						cat $HOME/.sa_dia/day_class/E.txt | awk -v cc=$cclass_room '{print $1,$2,cc,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/E.txt
					fi
					if [ $dd -eq "4" ]; then
						cat $HOME/.sa_dia/day_class/E.txt | awk -v cc=$cclass_room '{print $1,$2,$3,cc,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/E.txt
					fi
					if [ $dd -eq "5" ]; then
						cat $HOME/.sa_dia/day_class/E.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,cc,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/E.txt
					fi
					if [ $dd -eq "6" ]; then
						cat $HOME/.sa_dia/day_class/E.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,$5,cc}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/E.txt
					fi
				fi

				if [ $tt == "F" ]; then
					if [ $dd -eq "1" ]; then
						cat $HOME/.sa_dia/day_class/F.txt | awk -v cc=$cclass_room '{print cc,$2,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/F.txt
					fi
					if [ $dd -eq "2" ]; then
						cat $HOME/.sa_dia/day_class/F.txt | awk -v cc=$cclass_room '{print $1,cc,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/F.txt
					fi
					if [ $dd -eq "3" ]; then
						cat $HOME/.sa_dia/day_class/F.txt | awk -v cc=$cclass_room '{print $1,$2,cc,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/F.txt
					fi
					if [ $dd -eq "4" ]; then
						cat $HOME/.sa_dia/day_class/F.txt | awk -v cc=$cclass_room '{print $1,$2,$3,cc,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/F.txt
					fi
					if [ $dd -eq "5" ]; then
						cat $HOME/.sa_dia/day_class/F.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,cc,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/F.txt
					fi
					if [ $dd -eq "6" ]; then
						cat $HOME/.sa_dia/day_class/F.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,$5,cc}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/F.txt
					fi
				fi

				if [ $tt == "G" ]; then
					if [ $dd -eq "1" ]; then
						cat $HOME/.sa_dia/day_class/G.txt | awk -v cc=$cclass_room '{print cc,$2,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/G.txt
					fi
					if [ $dd -eq "2" ]; then
						cat $HOME/.sa_dia/day_class/G.txt | awk -v cc=$cclass_room '{print $1,cc,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/G.txt
					fi
					if [ $dd -eq "3" ]; then
						cat $HOME/.sa_dia/day_class/G.txt | awk -v cc=$cclass_room '{print $1,$2,cc,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/G.txt
					fi
					if [ $dd -eq "4" ]; then
						cat $HOME/.sa_dia/day_class/G.txt | awk -v cc=$cclass_room '{print $1,$2,$3,cc,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/G.txt
					fi
					if [ $dd -eq "5" ]; then
						cat $HOME/.sa_dia/day_class/G.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,cc,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/G.txt
					fi
					if [ $dd -eq "6" ]; then
						cat $HOME/.sa_dia/day_class/G.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,$5,cc}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/G.txt
					fi
				fi

				if [ $tt == "H" ]; then
					if [ $dd -eq "1" ]; then
						cat $HOME/.sa_dia/day_class/H.txt | awk -v cc=$cclass_room '{print cc,$2,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/H.txt
					fi
					if [ $dd -eq "2" ]; then
						cat $HOME/.sa_dia/day_class/H.txt | awk -v cc=$cclass_room '{print $1,cc,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/H.txt
					fi
					if [ $dd -eq "3" ]; then
						cat $HOME/.sa_dia/day_class/H.txt | awk -v cc=$cclass_room '{print $1,$2,cc,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/H.txt
					fi
					if [ $dd -eq "4" ]; then
						cat $HOME/.sa_dia/day_class/H.txt | awk -v cc=$cclass_room '{print $1,$2,$3,cc,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/H.txt
					fi
					if [ $dd -eq "5" ]; then
						cat $HOME/.sa_dia/day_class/H.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,cc,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/H.txt
					fi
					if [ $dd -eq "6" ]; then
						cat $HOME/.sa_dia/day_class/H.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,$5,cc}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/H.txt
					fi
				fi

				if [ $tt == "Y" ]; then
					if [ $dd -eq "1" ]; then
						cat $HOME/.sa_dia/day_class/Y.txt | awk -v cc=$cclass_room '{print cc,$2,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/Y.txt
					fi
					if [ $dd -eq "2" ]; then
						cat $HOME/.sa_dia/day_class/Y.txt | awk -v cc=$cclass_room '{print $1,cc,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/Y.txt
					fi
					if [ $dd -eq "3" ]; then
						cat $HOME/.sa_dia/day_class/Y.txt | awk -v cc=$cclass_room '{print $1,$2,cc,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/Y.txt
					fi
					if [ $dd -eq "4" ]; then
						cat $HOME/.sa_dia/day_class/Y.txt | awk -v cc=$cclass_room '{print $1,$2,$3,cc,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/Y.txt
					fi
					if [ $dd -eq "5" ]; then
						cat $HOME/.sa_dia/day_class/Y.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,cc,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/Y.txt
					fi
					if [ $dd -eq "6" ]; then
						cat $HOME/.sa_dia/day_class/Y.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,$5,cc}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/Y.txt
					fi
				fi

				if [ $tt == "I" ]; then
					if [ $dd -eq "1" ]; then
						cat $HOME/.sa_dia/day_class/I.txt | awk -v cc=$cclass_room '{print cc,$2,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/I.txt
					fi
					if [ $dd -eq "2" ]; then
						cat $HOME/.sa_dia/day_class/I.txt | awk -v cc=$cclass_room '{print $1,cc,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/I.txt
					fi
					if [ $dd -eq "3" ]; then
						cat $HOME/.sa_dia/day_class/I.txt | awk -v cc=$cclass_room '{print $1,$2,cc,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/I.txt
					fi
					if [ $dd -eq "4" ]; then
						cat $HOME/.sa_dia/day_class/I.txt | awk -v cc=$cclass_room '{print $1,$2,$3,cc,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/I.txt
					fi
					if [ $dd -eq "5" ]; then
						cat $HOME/.sa_dia/day_class/I.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,cc,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/I.txt
					fi
					if [ $dd -eq "6" ]; then
						cat $HOME/.sa_dia/day_class/I.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,$5,cc}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/I.txt
					fi
				fi

				if [ $tt == "J" ]; then
					if [ $dd -eq "1" ]; then
						cat $HOME/.sa_dia/day_class/J.txt | awk -v cc=$cclass_room '{print cc,$2,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/J.txt
					fi
					if [ $dd -eq "2" ]; then
						cat $HOME/.sa_dia/day_class/J.txt | awk -v cc=$cclass_room '{print $1,cc,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/J.txt
					fi
					if [ $dd -eq "3" ]; then
						cat $HOME/.sa_dia/day_class/J.txt | awk -v cc=$cclass_room '{print $1,$2,cc,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/J.txt
					fi
					if [ $dd -eq "4" ]; then
						cat $HOME/.sa_dia/day_class/J.txt | awk -v cc=$cclass_room '{print $1,$2,$3,cc,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/J.txt
					fi
					if [ $dd -eq "5" ]; then
						cat $HOME/.sa_dia/day_class/J.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,cc,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/J.txt
					fi
					if [ $dd -eq "6" ]; then
						cat $HOME/.sa_dia/day_class/J.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,$5,cc}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/J.txt
					fi
				fi

				if [ $tt == "K" ]; then
					if [ $dd -eq "1" ]; then
						cat $HOME/.sa_dia/day_class/K.txt | awk -v cc=$cclass_room '{print cc,$2,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/K.txt
					fi
					if [ $dd -eq "2" ]; then
						cat $HOME/.sa_dia/day_class/K.txt | awk -v cc=$cclass_room '{print $1,cc,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/K.txt
					fi
					if [ $dd -eq "3" ]; then
						cat $HOME/.sa_dia/day_class/K.txt | awk -v cc=$cclass_room '{print $1,$2,cc,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/K.txt
					fi
					if [ $dd -eq "4" ]; then
						cat $HOME/.sa_dia/day_class/K.txt | awk -v cc=$cclass_room '{print $1,$2,$3,cc,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/K.txt
					fi
					if [ $dd -eq "5" ]; then
						cat $HOME/.sa_dia/day_class/K.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,cc,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/K.txt
					fi
					if [ $dd -eq "6" ]; then
						cat $HOME/.sa_dia/day_class/K.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,$5,cc}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/K.txt
					fi
				fi
			fi

			################################################################## single done
			if [ $num -eq "3" ]; then 
				tt=`echo "$j" | head -c 2 | tail -c 1` ##time ### 1
				if [ $tt == "N" ]; then
					if [ $dd -eq "1" ]; then
						cat $HOME/.sa_dia/day_class/N.txt | awk -v cc=$cclass_room '{print cc,$2,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/N.txt
					fi
					if [ $dd -eq "2" ]; then
						cat $HOME/.sa_dia/day_class/N.txt | awk -v cc=$cclass_room '{print $1,cc,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/N.txt
					fi
					if [ $dd -eq "3" ]; then
						cat $HOME/.sa_dia/day_class/N.txt | awk -v cc=$cclass_room '{print $1,$2,cc,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/N.txt
					fi
					if [ $dd -eq "4" ]; then
						cat $HOME/.sa_dia/day_class/N.txt | awk -v cc=$cclass_room '{print $1,$2,$3,cc,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/N.txt
					fi
					if [ $dd -eq "5" ]; then
						cat $HOME/.sa_dia/day_class/N.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,cc,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/N.txt
					fi
					if [ $dd -eq "6" ]; then
						cat $HOME/.sa_dia/day_class/N.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,$5,cc}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/N.txt
					fi
				fi

				if [ $tt == "A" ]; then
					if [ $dd -eq "1" ]; then
						cat $HOME/.sa_dia/day_class/A.txt | awk -v cc=$cclass_room '{print cc,$2,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/A.txt
					fi
					if [ $dd -eq "2" ]; then
						cat $HOME/.sa_dia/day_class/A.txt | awk -v cc=$cclass_room '{print $1,cc,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/A.txt
					fi
					if [ $dd -eq "3" ]; then
						cat $HOME/.sa_dia/day_class/A.txt | awk -v cc=$cclass_room '{print $1,$2,cc,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/A.txt
					fi
					if [ $dd -eq "4" ]; then
						cat $HOME/.sa_dia/day_class/A.txt | awk -v cc=$cclass_room '{print $1,$2,$3,cc,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/A.txt
					fi
					if [ $dd -eq "5" ]; then
						cat $HOME/.sa_dia/day_class/A.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,cc,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/A.txt
					fi
					if [ $dd -eq "6" ]; then
						cat $HOME/.sa_dia/day_class/A.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,$5,cc}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/A.txt
					fi
				fi

				if [ $tt == "B" ]; then
					if [ $dd -eq "1" ]; then
						cat $HOME/.sa_dia/day_class/B.txt | awk -v cc=$cclass_room '{print cc,$2,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/B.txt
					fi
					if [ $dd -eq "2" ]; then
						cat $HOME/.sa_dia/day_class/B.txt | awk -v cc=$cclass_room '{print $1,cc,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/B.txt
					fi
					if [ $dd -eq "3" ]; then
						cat $HOME/.sa_dia/day_class/B.txt | awk -v cc=$cclass_room '{print $1,$2,cc,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/B.txt
					fi
					if [ $dd -eq "4" ]; then
						cat $HOME/.sa_dia/day_class/B.txt | awk -v cc=$cclass_room '{print $1,$2,$3,cc,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/B.txt
					fi
					if [ $dd -eq "5" ]; then
						cat $HOME/.sa_dia/day_class/B.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,cc,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/B.txt
					fi
					if [ $dd -eq "6" ]; then
						cat $HOME/.sa_dia/day_class/B.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,$5,cc}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/B.txt
					fi
				fi

				if [ $tt == "C" ]; then
					if [ $dd -eq "1" ]; then
						cat $HOME/.sa_dia/day_class/C.txt | awk -v cc=$cclass_room '{print cc,$2,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/C.txt
					fi
					if [ $dd -eq "2" ]; then
						cat $HOME/.sa_dia/day_class/C.txt | awk -v cc=$cclass_room '{print $1,cc,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/C.txt
					fi
					if [ $dd -eq "3" ]; then
						cat $HOME/.sa_dia/day_class/C.txt | awk -v cc=$cclass_room '{print $1,$2,cc,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/C.txt
					fi
					if [ $dd -eq "4" ]; then
						cat $HOME/.sa_dia/day_class/C.txt | awk -v cc=$cclass_room '{print $1,$2,$3,cc,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/C.txt
					fi
					if [ $dd -eq "5" ]; then
						cat $HOME/.sa_dia/day_class/C.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,cc,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/C.txt
					fi
					if [ $dd -eq "6" ]; then
						cat $HOME/.sa_dia/day_class/C.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,$5,cc}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/C.txt
					fi
				fi

				if [ $tt == "D" ]; then
					if [ $dd -eq "1" ]; then
						cat $HOME/.sa_dia/day_class/D.txt | awk -v cc=$cclass_room '{print cc,$2,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/D.txt
					fi
					if [ $dd -eq "2" ]; then
						cat $HOME/.sa_dia/day_class/D.txt | awk -v cc=$cclass_room '{print $1,cc,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/D.txt
					fi
					if [ $dd -eq "3" ]; then
						cat $HOME/.sa_dia/day_class/D.txt | awk -v cc=$cclass_room '{print $1,$2,cc,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/D.txt
					fi
					if [ $dd -eq "4" ]; then
						cat $HOME/.sa_dia/day_class/D.txt | awk -v cc=$cclass_room '{print $1,$2,$3,cc,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/D.txt
					fi
					if [ $dd -eq "5" ]; then
						cat $HOME/.sa_dia/day_class/D.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,cc,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/D.txt
					fi
					if [ $dd -eq "6" ]; then
						cat $HOME/.sa_dia/day_class/D.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,$5,cc}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/D.txt
					fi
				fi

				if [ $tt == "X" ]; then
					if [ $dd -eq "1" ]; then
						cat $HOME/.sa_dia/day_class/X.txt | awk -v cc=$cclass_room '{print cc,$2,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/X.txt
					fi
					if [ $dd -eq "2" ]; then
						cat $HOME/.sa_dia/day_class/X.txt | awk -v cc=$cclass_room '{print $1,cc,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/X.txt
					fi
					if [ $dd -eq "3" ]; then
						cat $HOME/.sa_dia/day_class/X.txt | awk -v cc=$cclass_room '{print $1,$2,cc,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/X.txt
					fi
					if [ $dd -eq "4" ]; then
						cat $HOME/.sa_dia/day_class/X.txt | awk -v cc=$cclass_room '{print $1,$2,$3,cc,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/X.txt
					fi
					if [ $dd -eq "5" ]; then
						cat $HOME/.sa_dia/day_class/X.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,cc,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/X.txt
					fi
					if [ $dd -eq "6" ]; then
						cat $HOME/.sa_dia/day_class/X.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,$5,cc}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/X.txt
					fi
				fi

				if [ $tt == "E" ]; then
					if [ $dd -eq "1" ]; then
						cat $HOME/.sa_dia/day_class/E.txt | awk -v cc=$cclass_room '{print cc,$2,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/E.txt
					fi
					if [ $dd -eq "2" ]; then
						cat $HOME/.sa_dia/day_class/E.txt | awk -v cc=$cclass_room '{print $1,cc,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/E.txt
					fi
					if [ $dd -eq "3" ]; then
						cat $HOME/.sa_dia/day_class/E.txt | awk -v cc=$cclass_room '{print $1,$2,cc,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/E.txt
					fi
					if [ $dd -eq "4" ]; then
						cat $HOME/.sa_dia/day_class/E.txt | awk -v cc=$cclass_room '{print $1,$2,$3,cc,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/E.txt
					fi
					if [ $dd -eq "5" ]; then
						cat $HOME/.sa_dia/day_class/E.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,cc,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/E.txt
					fi
					if [ $dd -eq "6" ]; then
						cat $HOME/.sa_dia/day_class/E.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,$5,cc}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/E.txt
					fi
				fi

				if [ $tt == "F" ]; then
					if [ $dd -eq "1" ]; then
						cat $HOME/.sa_dia/day_class/F.txt | awk -v cc=$cclass_room '{print cc,$2,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/F.txt
					fi
					if [ $dd -eq "2" ]; then
						cat $HOME/.sa_dia/day_class/F.txt | awk -v cc=$cclass_room '{print $1,cc,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/F.txt
					fi
					if [ $dd -eq "3" ]; then
						cat $HOME/.sa_dia/day_class/F.txt | awk -v cc=$cclass_room '{print $1,$2,cc,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/F.txt
					fi
					if [ $dd -eq "4" ]; then
						cat $HOME/.sa_dia/day_class/F.txt | awk -v cc=$cclass_room '{print $1,$2,$3,cc,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/F.txt
					fi
					if [ $dd -eq "5" ]; then
						cat $HOME/.sa_dia/day_class/F.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,cc,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/F.txt
					fi
					if [ $dd -eq "6" ]; then
						cat $HOME/.sa_dia/day_class/F.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,$5,cc}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/F.txt
					fi
				fi

				if [ $tt == "G" ]; then
					if [ $dd -eq "1" ]; then
						cat $HOME/.sa_dia/day_class/G.txt | awk -v cc=$cclass_room '{print cc,$2,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/G.txt
					fi
					if [ $dd -eq "2" ]; then
						cat $HOME/.sa_dia/day_class/G.txt | awk -v cc=$cclass_room '{print $1,cc,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/G.txt
					fi
					if [ $dd -eq "3" ]; then
						cat $HOME/.sa_dia/day_class/G.txt | awk -v cc=$cclass_room '{print $1,$2,cc,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/G.txt
					fi
					if [ $dd -eq "4" ]; then
						cat $HOME/.sa_dia/day_class/G.txt | awk -v cc=$cclass_room '{print $1,$2,$3,cc,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/G.txt
					fi
					if [ $dd -eq "5" ]; then
						cat $HOME/.sa_dia/day_class/G.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,cc,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/G.txt
					fi
					if [ $dd -eq "6" ]; then
						cat $HOME/.sa_dia/day_class/G.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,$5,cc}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/G.txt
					fi
				fi

				if [ $tt == "H" ]; then
					if [ $dd -eq "1" ]; then
						cat $HOME/.sa_dia/day_class/H.txt | awk -v cc=$cclass_room '{print cc,$2,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/H.txt
					fi
					if [ $dd -eq "2" ]; then
						cat $HOME/.sa_dia/day_class/H.txt | awk -v cc=$cclass_room '{print $1,cc,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/H.txt
					fi
					if [ $dd -eq "3" ]; then
						cat $HOME/.sa_dia/day_class/H.txt | awk -v cc=$cclass_room '{print $1,$2,cc,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/H.txt
					fi
					if [ $dd -eq "4" ]; then
						cat $HOME/.sa_dia/day_class/H.txt | awk -v cc=$cclass_room '{print $1,$2,$3,cc,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/H.txt
					fi
					if [ $dd -eq "5" ]; then
						cat $HOME/.sa_dia/day_class/H.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,cc,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/H.txt
					fi
					if [ $dd -eq "6" ]; then
						cat $HOME/.sa_dia/day_class/H.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,$5,cc}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/H.txt
					fi
				fi

				if [ $tt == "Y" ]; then
					if [ $dd -eq "1" ]; then
						cat $HOME/.sa_dia/day_class/Y.txt | awk -v cc=$cclass_room '{print cc,$2,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/Y.txt
					fi
					if [ $dd -eq "2" ]; then
						cat $HOME/.sa_dia/day_class/Y.txt | awk -v cc=$cclass_room '{print $1,cc,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/Y.txt
					fi
					if [ $dd -eq "3" ]; then
						cat $HOME/.sa_dia/day_class/Y.txt | awk -v cc=$cclass_room '{print $1,$2,cc,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/Y.txt
					fi
					if [ $dd -eq "4" ]; then
						cat $HOME/.sa_dia/day_class/Y.txt | awk -v cc=$cclass_room '{print $1,$2,$3,cc,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/Y.txt
					fi
					if [ $dd -eq "5" ]; then
						cat $HOME/.sa_dia/day_class/Y.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,cc,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/Y.txt
					fi
					if [ $dd -eq "6" ]; then
						cat $HOME/.sa_dia/day_class/Y.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,$5,cc}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/Y.txt
					fi
				fi

				if [ $tt == "I" ]; then
					if [ $dd -eq "1" ]; then
						cat $HOME/.sa_dia/day_class/I.txt | awk -v cc=$cclass_room '{print cc,$2,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/I.txt
					fi
					if [ $dd -eq "2" ]; then
						cat $HOME/.sa_dia/day_class/I.txt | awk -v cc=$cclass_room '{print $1,cc,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/I.txt
					fi
					if [ $dd -eq "3" ]; then
						cat $HOME/.sa_dia/day_class/I.txt | awk -v cc=$cclass_room '{print $1,$2,cc,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/I.txt
					fi
					if [ $dd -eq "4" ]; then
						cat $HOME/.sa_dia/day_class/I.txt | awk -v cc=$cclass_room '{print $1,$2,$3,cc,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/I.txt
					fi
					if [ $dd -eq "5" ]; then
						cat $HOME/.sa_dia/day_class/I.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,cc,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/I.txt
					fi
					if [ $dd -eq "6" ]; then
						cat $HOME/.sa_dia/day_class/I.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,$5,cc}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/I.txt
					fi
				fi

				if [ $tt == "J" ]; then
					if [ $dd -eq "1" ]; then
						cat $HOME/.sa_dia/day_class/J.txt | awk -v cc=$cclass_room '{print cc,$2,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/J.txt
					fi
					if [ $dd -eq "2" ]; then
						cat $HOME/.sa_dia/day_class/J.txt | awk -v cc=$cclass_room '{print $1,cc,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/J.txt
					fi
					if [ $dd -eq "3" ]; then
						cat $HOME/.sa_dia/day_class/J.txt | awk -v cc=$cclass_room '{print $1,$2,cc,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/J.txt
					fi
					if [ $dd -eq "4" ]; then
						cat $HOME/.sa_dia/day_class/J.txt | awk -v cc=$cclass_room '{print $1,$2,$3,cc,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/J.txt
					fi
					if [ $dd -eq "5" ]; then
						cat $HOME/.sa_dia/day_class/J.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,cc,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/J.txt
					fi
					if [ $dd -eq "6" ]; then
						cat $HOME/.sa_dia/day_class/J.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,$5,cc}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/J.txt
					fi
				fi

				if [ $tt == "K" ]; then
					if [ $dd -eq "1" ]; then
						cat $HOME/.sa_dia/day_class/K.txt | awk -v cc=$cclass_room '{print cc,$2,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/K.txt
					fi
					if [ $dd -eq "2" ]; then
						cat $HOME/.sa_dia/day_class/K.txt | awk -v cc=$cclass_room '{print $1,cc,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/K.txt
					fi
					if [ $dd -eq "3" ]; then
						cat $HOME/.sa_dia/day_class/K.txt | awk -v cc=$cclass_room '{print $1,$2,cc,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/K.txt
					fi
					if [ $dd -eq "4" ]; then
						cat $HOME/.sa_dia/day_class/K.txt | awk -v cc=$cclass_room '{print $1,$2,$3,cc,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/K.txt
					fi
					if [ $dd -eq "5" ]; then
						cat $HOME/.sa_dia/day_class/K.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,cc,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/K.txt
					fi
					if [ $dd -eq "6" ]; then
						cat $HOME/.sa_dia/day_class/K.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,$5,cc}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/K.txt
					fi
				fi

				tt=`echo "$j" | head -c 3 | tail -c 1` ##time ###2
				if [ $tt == "N" ]; then
					if [ $dd -eq "1" ]; then
						cat $HOME/.sa_dia/day_class/N.txt | awk -v cc=$cclass_room '{print cc,$2,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/N.txt
					fi
					if [ $dd -eq "2" ]; then
						cat $HOME/.sa_dia/day_class/N.txt | awk -v cc=$cclass_room '{print $1,cc,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/N.txt
					fi
					if [ $dd -eq "3" ]; then
						cat $HOME/.sa_dia/day_class/N.txt | awk -v cc=$cclass_room '{print $1,$2,cc,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/N.txt
					fi
					if [ $dd -eq "4" ]; then
						cat $HOME/.sa_dia/day_class/N.txt | awk -v cc=$cclass_room '{print $1,$2,$3,cc,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/N.txt
					fi
					if [ $dd -eq "5" ]; then
						cat $HOME/.sa_dia/day_class/N.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,cc,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/N.txt
					fi
					if [ $dd -eq "6" ]; then
						cat $HOME/.sa_dia/day_class/N.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,$5,cc}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/N.txt
					fi
				fi

				if [ $tt == "A" ]; then
					if [ $dd -eq "1" ]; then
						cat $HOME/.sa_dia/day_class/A.txt | awk -v cc=$cclass_room '{print cc,$2,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/A.txt
					fi
					if [ $dd -eq "2" ]; then
						cat $HOME/.sa_dia/day_class/A.txt | awk -v cc=$cclass_room '{print $1,cc,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/A.txt
					fi
					if [ $dd -eq "3" ]; then
						cat $HOME/.sa_dia/day_class/A.txt | awk -v cc=$cclass_room '{print $1,$2,cc,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/A.txt
					fi
					if [ $dd -eq "4" ]; then
						cat $HOME/.sa_dia/day_class/A.txt | awk -v cc=$cclass_room '{print $1,$2,$3,cc,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/A.txt
					fi
					if [ $dd -eq "5" ]; then
						cat $HOME/.sa_dia/day_class/A.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,cc,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/A.txt
					fi
					if [ $dd -eq "6" ]; then
						cat $HOME/.sa_dia/day_class/A.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,$5,cc}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/A.txt
					fi
				fi

				if [ $tt == "B" ]; then
					if [ $dd -eq "1" ]; then
						cat $HOME/.sa_dia/day_class/B.txt | awk -v cc=$cclass_room '{print cc,$2,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/B.txt
					fi
					if [ $dd -eq "2" ]; then
						cat $HOME/.sa_dia/day_class/B.txt | awk -v cc=$cclass_room '{print $1,cc,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/B.txt
					fi
					if [ $dd -eq "3" ]; then
						cat $HOME/.sa_dia/day_class/B.txt | awk -v cc=$cclass_room '{print $1,$2,cc,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/B.txt
					fi
					if [ $dd -eq "4" ]; then
						cat $HOME/.sa_dia/day_class/B.txt | awk -v cc=$cclass_room '{print $1,$2,$3,cc,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/B.txt
					fi
					if [ $dd -eq "5" ]; then
						cat $HOME/.sa_dia/day_class/B.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,cc,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/B.txt
					fi
					if [ $dd -eq "6" ]; then
						cat $HOME/.sa_dia/day_class/B.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,$5,cc}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/B.txt
					fi
				fi

				if [ $tt == "C" ]; then
					if [ $dd -eq "1" ]; then
						cat $HOME/.sa_dia/day_class/C.txt | awk -v cc=$cclass_room '{print cc,$2,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/C.txt
					fi
					if [ $dd -eq "2" ]; then
						cat $HOME/.sa_dia/day_class/C.txt | awk -v cc=$cclass_room '{print $1,cc,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/C.txt
					fi
					if [ $dd -eq "3" ]; then
						cat $HOME/.sa_dia/day_class/C.txt | awk -v cc=$cclass_room '{print $1,$2,cc,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/C.txt
					fi
					if [ $dd -eq "4" ]; then
						cat $HOME/.sa_dia/day_class/C.txt | awk -v cc=$cclass_room '{print $1,$2,$3,cc,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/C.txt
					fi
					if [ $dd -eq "5" ]; then
						cat $HOME/.sa_dia/day_class/C.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,cc,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/C.txt
					fi
					if [ $dd -eq "6" ]; then
						cat $HOME/.sa_dia/day_class/C.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,$5,cc}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/C.txt
					fi
				fi

				if [ $tt == "D" ]; then
					if [ $dd -eq "1" ]; then
						cat $HOME/.sa_dia/day_class/D.txt | awk -v cc=$cclass_room '{print cc,$2,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/D.txt
					fi
					if [ $dd -eq "2" ]; then
						cat $HOME/.sa_dia/day_class/D.txt | awk -v cc=$cclass_room '{print $1,cc,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/D.txt
					fi
					if [ $dd -eq "3" ]; then
						cat $HOME/.sa_dia/day_class/D.txt | awk -v cc=$cclass_room '{print $1,$2,cc,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/D.txt
					fi
					if [ $dd -eq "4" ]; then
						cat $HOME/.sa_dia/day_class/D.txt | awk -v cc=$cclass_room '{print $1,$2,$3,cc,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/D.txt
					fi
					if [ $dd -eq "5" ]; then
						cat $HOME/.sa_dia/day_class/D.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,cc,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/D.txt
					fi
					if [ $dd -eq "6" ]; then
						cat $HOME/.sa_dia/day_class/D.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,$5,cc}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/D.txt
					fi
				fi

				if [ $tt == "X" ]; then
					if [ $dd -eq "1" ]; then
						cat $HOME/.sa_dia/day_class/X.txt | awk -v cc=$cclass_room '{print cc,$2,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/X.txt
					fi
					if [ $dd -eq "2" ]; then
						cat $HOME/.sa_dia/day_class/X.txt | awk -v cc=$cclass_room '{print $1,cc,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/X.txt
					fi
					if [ $dd -eq "3" ]; then
						cat $HOME/.sa_dia/day_class/X.txt | awk -v cc=$cclass_room '{print $1,$2,cc,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/X.txt
					fi
					if [ $dd -eq "4" ]; then
						cat $HOME/.sa_dia/day_class/X.txt | awk -v cc=$cclass_room '{print $1,$2,$3,cc,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/X.txt
					fi
					if [ $dd -eq "5" ]; then
						cat $HOME/.sa_dia/day_class/X.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,cc,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/X.txt
					fi
					if [ $dd -eq "6" ]; then
						cat $HOME/.sa_dia/day_class/X.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,$5,cc}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/X.txt
					fi
				fi

				if [ $tt == "E" ]; then
					if [ $dd -eq "1" ]; then
						cat $HOME/.sa_dia/day_class/E.txt | awk -v cc=$cclass_room '{print cc,$2,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/E.txt
					fi
					if [ $dd -eq "2" ]; then
						cat $HOME/.sa_dia/day_class/E.txt | awk -v cc=$cclass_room '{print $1,cc,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/E.txt
					fi
					if [ $dd -eq "3" ]; then
						cat $HOME/.sa_dia/day_class/E.txt | awk -v cc=$cclass_room '{print $1,$2,cc,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/E.txt
					fi
					if [ $dd -eq "4" ]; then
						cat $HOME/.sa_dia/day_class/E.txt | awk -v cc=$cclass_room '{print $1,$2,$3,cc,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/E.txt
					fi
					if [ $dd -eq "5" ]; then
						cat $HOME/.sa_dia/day_class/E.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,cc,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/E.txt
					fi
					if [ $dd -eq "6" ]; then
						cat $HOME/.sa_dia/day_class/E.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,$5,cc}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/E.txt
					fi
				fi

				if [ $tt == "F" ]; then
					if [ $dd -eq "1" ]; then
						cat $HOME/.sa_dia/day_class/F.txt | awk -v cc=$cclass_room '{print cc,$2,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/F.txt
					fi
					if [ $dd -eq "2" ]; then
						cat $HOME/.sa_dia/day_class/F.txt | awk -v cc=$cclass_room '{print $1,cc,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/F.txt
					fi
					if [ $dd -eq "3" ]; then
						cat $HOME/.sa_dia/day_class/F.txt | awk -v cc=$cclass_room '{print $1,$2,cc,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/F.txt
					fi
					if [ $dd -eq "4" ]; then
						cat $HOME/.sa_dia/day_class/F.txt | awk -v cc=$cclass_room '{print $1,$2,$3,cc,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/F.txt
					fi
					if [ $dd -eq "5" ]; then
						cat $HOME/.sa_dia/day_class/F.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,cc,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/F.txt
					fi
					if [ $dd -eq "6" ]; then
						cat $HOME/.sa_dia/day_class/F.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,$5,cc}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/F.txt
					fi
				fi

				if [ $tt == "G" ]; then
					if [ $dd -eq "1" ]; then
						cat $HOME/.sa_dia/day_class/G.txt | awk -v cc=$cclass_room '{print cc,$2,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/G.txt
					fi
					if [ $dd -eq "2" ]; then
						cat $HOME/.sa_dia/day_class/G.txt | awk -v cc=$cclass_room '{print $1,cc,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/G.txt
					fi
					if [ $dd -eq "3" ]; then
						cat $HOME/.sa_dia/day_class/G.txt | awk -v cc=$cclass_room '{print $1,$2,cc,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/G.txt
					fi
					if [ $dd -eq "4" ]; then
						cat $HOME/.sa_dia/day_class/G.txt | awk -v cc=$cclass_room '{print $1,$2,$3,cc,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/G.txt
					fi
					if [ $dd -eq "5" ]; then
						cat $HOME/.sa_dia/day_class/G.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,cc,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/G.txt
					fi
					if [ $dd -eq "6" ]; then
						cat $HOME/.sa_dia/day_class/G.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,$5,cc}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/G.txt
					fi
				fi

				if [ $tt == "H" ]; then
					if [ $dd -eq "1" ]; then
						cat $HOME/.sa_dia/day_class/H.txt | awk -v cc=$cclass_room '{print cc,$2,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/H.txt
					fi
					if [ $dd -eq "2" ]; then
						cat $HOME/.sa_dia/day_class/H.txt | awk -v cc=$cclass_room '{print $1,cc,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/H.txt
					fi
					if [ $dd -eq "3" ]; then
						cat $HOME/.sa_dia/day_class/H.txt | awk -v cc=$cclass_room '{print $1,$2,cc,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/H.txt
					fi
					if [ $dd -eq "4" ]; then
						cat $HOME/.sa_dia/day_class/H.txt | awk -v cc=$cclass_room '{print $1,$2,$3,cc,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/H.txt
					fi
					if [ $dd -eq "5" ]; then
						cat $HOME/.sa_dia/day_class/H.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,cc,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/H.txt
					fi
					if [ $dd -eq "6" ]; then
						cat $HOME/.sa_dia/day_class/H.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,$5,cc}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/H.txt
					fi
				fi

				if [ $tt == "Y" ]; then
					if [ $dd -eq "1" ]; then
						cat $HOME/.sa_dia/day_class/Y.txt | awk -v cc=$cclass_room '{print cc,$2,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/Y.txt
					fi
					if [ $dd -eq "2" ]; then
						cat $HOME/.sa_dia/day_class/Y.txt | awk -v cc=$cclass_room '{print $1,cc,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/Y.txt
					fi
					if [ $dd -eq "3" ]; then
						cat $HOME/.sa_dia/day_class/Y.txt | awk -v cc=$cclass_room '{print $1,$2,cc,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/Y.txt
					fi
					if [ $dd -eq "4" ]; then
						cat $HOME/.sa_dia/day_class/Y.txt | awk -v cc=$cclass_room '{print $1,$2,$3,cc,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/Y.txt
					fi
					if [ $dd -eq "5" ]; then
						cat $HOME/.sa_dia/day_class/Y.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,cc,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/Y.txt
					fi
					if [ $dd -eq "6" ]; then
						cat $HOME/.sa_dia/day_class/Y.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,$5,cc}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/Y.txt
					fi
				fi

				if [ $tt == "I" ]; then
					if [ $dd -eq "1" ]; then
						cat $HOME/.sa_dia/day_class/I.txt | awk -v cc=$cclass_room '{print cc,$2,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/I.txt
					fi
					if [ $dd -eq "2" ]; then
						cat $HOME/.sa_dia/day_class/I.txt | awk -v cc=$cclass_room '{print $1,cc,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/I.txt
					fi
					if [ $dd -eq "3" ]; then
						cat $HOME/.sa_dia/day_class/I.txt | awk -v cc=$cclass_room '{print $1,$2,cc,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/I.txt
					fi
					if [ $dd -eq "4" ]; then
						cat $HOME/.sa_dia/day_class/I.txt | awk -v cc=$cclass_room '{print $1,$2,$3,cc,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/I.txt
					fi
					if [ $dd -eq "5" ]; then
						cat $HOME/.sa_dia/day_class/I.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,cc,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/I.txt
					fi
					if [ $dd -eq "6" ]; then
						cat $HOME/.sa_dia/day_class/I.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,$5,cc}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/I.txt
					fi
				fi

				if [ $tt == "J" ]; then
					if [ $dd -eq "1" ]; then
						cat $HOME/.sa_dia/day_class/J.txt | awk -v cc=$cclass_room '{print cc,$2,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/J.txt
					fi
					if [ $dd -eq "2" ]; then
						cat $HOME/.sa_dia/day_class/J.txt | awk -v cc=$cclass_room '{print $1,cc,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/J.txt
					fi
					if [ $dd -eq "3" ]; then
						cat $HOME/.sa_dia/day_class/J.txt | awk -v cc=$cclass_room '{print $1,$2,cc,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/J.txt
					fi
					if [ $dd -eq "4" ]; then
						cat $HOME/.sa_dia/day_class/J.txt | awk -v cc=$cclass_room '{print $1,$2,$3,cc,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/J.txt
					fi
					if [ $dd -eq "5" ]; then
						cat $HOME/.sa_dia/day_class/J.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,cc,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/J.txt
					fi
					if [ $dd -eq "6" ]; then
						cat $HOME/.sa_dia/day_class/J.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,$5,cc}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/J.txt
					fi
				fi

				if [ $tt == "K" ]; then
					if [ $dd -eq "1" ]; then
						cat $HOME/.sa_dia/day_class/K.txt | awk -v cc=$cclass_room '{print cc,$2,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/K.txt
					fi
					if [ $dd -eq "2" ]; then
						cat $HOME/.sa_dia/day_class/K.txt | awk -v cc=$cclass_room '{print $1,cc,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/K.txt
					fi
					if [ $dd -eq "3" ]; then
						cat $HOME/.sa_dia/day_class/K.txt | awk -v cc=$cclass_room '{print $1,$2,cc,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/K.txt
					fi
					if [ $dd -eq "4" ]; then
						cat $HOME/.sa_dia/day_class/K.txt | awk -v cc=$cclass_room '{print $1,$2,$3,cc,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/K.txt
					fi
					if [ $dd -eq "5" ]; then
						cat $HOME/.sa_dia/day_class/K.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,cc,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/K.txt
					fi
					if [ $dd -eq "6" ]; then
						cat $HOME/.sa_dia/day_class/K.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,$5,cc}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/K.txt
					fi
				fi

			fi
			####################################################################### double_done
			if [ $num -eq "4" ]; then 
				tt=`echo "$j" | head -c 2 | tail -c 1` ##time ### 1
				if [ $tt == "N" ]; then
					if [ $dd -eq "1" ]; then
						cat $HOME/.sa_dia/day_class/N.txt | awk -v cc=$cclass_room '{print cc,$2,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/N.txt
					fi
					if [ $dd -eq "2" ]; then
						cat $HOME/.sa_dia/day_class/N.txt | awk -v cc=$cclass_room '{print $1,cc,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/N.txt
					fi
					if [ $dd -eq "3" ]; then
						cat $HOME/.sa_dia/day_class/N.txt | awk -v cc=$cclass_room '{print $1,$2,cc,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/N.txt
					fi
					if [ $dd -eq "4" ]; then
						cat $HOME/.sa_dia/day_class/N.txt | awk -v cc=$cclass_room '{print $1,$2,$3,cc,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/N.txt
					fi
					if [ $dd -eq "5" ]; then
						cat $HOME/.sa_dia/day_class/N.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,cc,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/N.txt
					fi
					if [ $dd -eq "6" ]; then
						cat $HOME/.sa_dia/day_class/N.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,$5,cc}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/N.txt
					fi
				fi

				if [ $tt == "A" ]; then
					if [ $dd -eq "1" ]; then
						cat $HOME/.sa_dia/day_class/A.txt | awk -v cc=$cclass_room '{print cc,$2,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/A.txt
					fi
					if [ $dd -eq "2" ]; then
						cat $HOME/.sa_dia/day_class/A.txt | awk -v cc=$cclass_room '{print $1,cc,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/A.txt
					fi
					if [ $dd -eq "3" ]; then
						cat $HOME/.sa_dia/day_class/A.txt | awk -v cc=$cclass_room '{print $1,$2,cc,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/A.txt
					fi
					if [ $dd -eq "4" ]; then
						cat $HOME/.sa_dia/day_class/A.txt | awk -v cc=$cclass_room '{print $1,$2,$3,cc,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/A.txt
					fi
					if [ $dd -eq "5" ]; then
						cat $HOME/.sa_dia/day_class/A.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,cc,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/A.txt
					fi
					if [ $dd -eq "6" ]; then
						cat $HOME/.sa_dia/day_class/A.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,$5,cc}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/A.txt
					fi
				fi

				if [ $tt == "B" ]; then
					if [ $dd -eq "1" ]; then
						cat $HOME/.sa_dia/day_class/B.txt | awk -v cc=$cclass_room '{print cc,$2,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/B.txt
					fi
					if [ $dd -eq "2" ]; then
						cat $HOME/.sa_dia/day_class/B.txt | awk -v cc=$cclass_room '{print $1,cc,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/B.txt
					fi
					if [ $dd -eq "3" ]; then
						cat $HOME/.sa_dia/day_class/B.txt | awk -v cc=$cclass_room '{print $1,$2,cc,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/B.txt
					fi
					if [ $dd -eq "4" ]; then
						cat $HOME/.sa_dia/day_class/B.txt | awk -v cc=$cclass_room '{print $1,$2,$3,cc,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/B.txt
					fi
					if [ $dd -eq "5" ]; then
						cat $HOME/.sa_dia/day_class/B.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,cc,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/B.txt
					fi
					if [ $dd -eq "6" ]; then
						cat $HOME/.sa_dia/day_class/B.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,$5,cc}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/B.txt
					fi
				fi

				if [ $tt == "C" ]; then
					if [ $dd -eq "1" ]; then
						cat $HOME/.sa_dia/day_class/C.txt | awk -v cc=$cclass_room '{print cc,$2,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/C.txt
					fi
					if [ $dd -eq "2" ]; then
						cat $HOME/.sa_dia/day_class/C.txt | awk -v cc=$cclass_room '{print $1,cc,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/C.txt
					fi
					if [ $dd -eq "3" ]; then
						cat $HOME/.sa_dia/day_class/C.txt | awk -v cc=$cclass_room '{print $1,$2,cc,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/C.txt
					fi
					if [ $dd -eq "4" ]; then
						cat $HOME/.sa_dia/day_class/C.txt | awk -v cc=$cclass_room '{print $1,$2,$3,cc,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/C.txt
					fi
					if [ $dd -eq "5" ]; then
						cat $HOME/.sa_dia/day_class/C.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,cc,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/C.txt
					fi
					if [ $dd -eq "6" ]; then
						cat $HOME/.sa_dia/day_class/C.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,$5,cc}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/C.txt
					fi
				fi

				if [ $tt == "D" ]; then
					if [ $dd -eq "1" ]; then
						cat $HOME/.sa_dia/day_class/D.txt | awk -v cc=$cclass_room '{print cc,$2,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/D.txt
					fi
					if [ $dd -eq "2" ]; then
						cat $HOME/.sa_dia/day_class/D.txt | awk -v cc=$cclass_room '{print $1,cc,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/D.txt
					fi
					if [ $dd -eq "3" ]; then
						cat $HOME/.sa_dia/day_class/D.txt | awk -v cc=$cclass_room '{print $1,$2,cc,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/D.txt
					fi
					if [ $dd -eq "4" ]; then
						cat $HOME/.sa_dia/day_class/D.txt | awk -v cc=$cclass_room '{print $1,$2,$3,cc,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/D.txt
					fi
					if [ $dd -eq "5" ]; then
						cat $HOME/.sa_dia/day_class/D.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,cc,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/D.txt
					fi
					if [ $dd -eq "6" ]; then
						cat $HOME/.sa_dia/day_class/D.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,$5,cc}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/D.txt
					fi
				fi

				if [ $tt == "X" ]; then
					if [ $dd -eq "1" ]; then
						cat $HOME/.sa_dia/day_class/X.txt | awk -v cc=$cclass_room '{print cc,$2,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/X.txt
					fi
					if [ $dd -eq "2" ]; then
						cat $HOME/.sa_dia/day_class/X.txt | awk -v cc=$cclass_room '{print $1,cc,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/X.txt
					fi
					if [ $dd -eq "3" ]; then
						cat $HOME/.sa_dia/day_class/X.txt | awk -v cc=$cclass_room '{print $1,$2,cc,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/X.txt
					fi
					if [ $dd -eq "4" ]; then
						cat $HOME/.sa_dia/day_class/X.txt | awk -v cc=$cclass_room '{print $1,$2,$3,cc,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/X.txt
					fi
					if [ $dd -eq "5" ]; then
						cat $HOME/.sa_dia/day_class/X.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,cc,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/X.txt
					fi
					if [ $dd -eq "6" ]; then
						cat $HOME/.sa_dia/day_class/X.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,$5,cc}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/X.txt
					fi
				fi

				if [ $tt == "E" ]; then
					if [ $dd -eq "1" ]; then
						cat $HOME/.sa_dia/day_class/E.txt | awk -v cc=$cclass_room '{print cc,$2,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/E.txt
					fi
					if [ $dd -eq "2" ]; then
						cat $HOME/.sa_dia/day_class/E.txt | awk -v cc=$cclass_room '{print $1,cc,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/E.txt
					fi
					if [ $dd -eq "3" ]; then
						cat $HOME/.sa_dia/day_class/E.txt | awk -v cc=$cclass_room '{print $1,$2,cc,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/E.txt
					fi
					if [ $dd -eq "4" ]; then
						cat $HOME/.sa_dia/day_class/E.txt | awk -v cc=$cclass_room '{print $1,$2,$3,cc,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/E.txt
					fi
					if [ $dd -eq "5" ]; then
						cat $HOME/.sa_dia/day_class/E.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,cc,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/E.txt
					fi
					if [ $dd -eq "6" ]; then
						cat $HOME/.sa_dia/day_class/E.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,$5,cc}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/E.txt
					fi
				fi

				if [ $tt == "F" ]; then
					if [ $dd -eq "1" ]; then
						cat $HOME/.sa_dia/day_class/F.txt | awk -v cc=$cclass_room '{print cc,$2,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/F.txt
					fi
					if [ $dd -eq "2" ]; then
						cat $HOME/.sa_dia/day_class/F.txt | awk -v cc=$cclass_room '{print $1,cc,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/F.txt
					fi
					if [ $dd -eq "3" ]; then
						cat $HOME/.sa_dia/day_class/F.txt | awk -v cc=$cclass_room '{print $1,$2,cc,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/F.txt
					fi
					if [ $dd -eq "4" ]; then
						cat $HOME/.sa_dia/day_class/F.txt | awk -v cc=$cclass_room '{print $1,$2,$3,cc,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/F.txt
					fi
					if [ $dd -eq "5" ]; then
						cat $HOME/.sa_dia/day_class/F.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,cc,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/F.txt
					fi
					if [ $dd -eq "6" ]; then
						cat $HOME/.sa_dia/day_class/F.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,$5,cc}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/F.txt
					fi
				fi

				if [ $tt == "G" ]; then
					if [ $dd -eq "1" ]; then
						cat $HOME/.sa_dia/day_class/G.txt | awk -v cc=$cclass_room '{print cc,$2,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/G.txt
					fi
					if [ $dd -eq "2" ]; then
						cat $HOME/.sa_dia/day_class/G.txt | awk -v cc=$cclass_room '{print $1,cc,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/G.txt
					fi
					if [ $dd -eq "3" ]; then
						cat $HOME/.sa_dia/day_class/G.txt | awk -v cc=$cclass_room '{print $1,$2,cc,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/G.txt
					fi
					if [ $dd -eq "4" ]; then
						cat $HOME/.sa_dia/day_class/G.txt | awk -v cc=$cclass_room '{print $1,$2,$3,cc,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/G.txt
					fi
					if [ $dd -eq "5" ]; then
						cat $HOME/.sa_dia/day_class/G.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,cc,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/G.txt
					fi
					if [ $dd -eq "6" ]; then
						cat $HOME/.sa_dia/day_class/G.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,$5,cc}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/G.txt
					fi
				fi

				if [ $tt == "H" ]; then
					if [ $dd -eq "1" ]; then
						cat $HOME/.sa_dia/day_class/H.txt | awk -v cc=$cclass_room '{print cc,$2,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/H.txt
					fi
					if [ $dd -eq "2" ]; then
						cat $HOME/.sa_dia/day_class/H.txt | awk -v cc=$cclass_room '{print $1,cc,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/H.txt
					fi
					if [ $dd -eq "3" ]; then
						cat $HOME/.sa_dia/day_class/H.txt | awk -v cc=$cclass_room '{print $1,$2,cc,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/H.txt
					fi
					if [ $dd -eq "4" ]; then
						cat $HOME/.sa_dia/day_class/H.txt | awk -v cc=$cclass_room '{print $1,$2,$3,cc,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/H.txt
					fi
					if [ $dd -eq "5" ]; then
						cat $HOME/.sa_dia/day_class/H.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,cc,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/H.txt
					fi
					if [ $dd -eq "6" ]; then
						cat $HOME/.sa_dia/day_class/H.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,$5,cc}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/H.txt
					fi
				fi

				if [ $tt == "Y" ]; then
					if [ $dd -eq "1" ]; then
						cat $HOME/.sa_dia/day_class/Y.txt | awk -v cc=$cclass_room '{print cc,$2,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/Y.txt
					fi
					if [ $dd -eq "2" ]; then
						cat $HOME/.sa_dia/day_class/Y.txt | awk -v cc=$cclass_room '{print $1,cc,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/Y.txt
					fi
					if [ $dd -eq "3" ]; then
						cat $HOME/.sa_dia/day_class/Y.txt | awk -v cc=$cclass_room '{print $1,$2,cc,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/Y.txt
					fi
					if [ $dd -eq "4" ]; then
						cat $HOME/.sa_dia/day_class/Y.txt | awk -v cc=$cclass_room '{print $1,$2,$3,cc,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/Y.txt
					fi
					if [ $dd -eq "5" ]; then
						cat $HOME/.sa_dia/day_class/Y.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,cc,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/Y.txt
					fi
					if [ $dd -eq "6" ]; then
						cat $HOME/.sa_dia/day_class/Y.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,$5,cc}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/Y.txt
					fi
				fi

				if [ $tt == "I" ]; then
					if [ $dd -eq "1" ]; then
						cat $HOME/.sa_dia/day_class/I.txt | awk -v cc=$cclass_room '{print cc,$2,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/I.txt
					fi
					if [ $dd -eq "2" ]; then
						cat $HOME/.sa_dia/day_class/I.txt | awk -v cc=$cclass_room '{print $1,cc,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/I.txt
					fi
					if [ $dd -eq "3" ]; then
						cat $HOME/.sa_dia/day_class/I.txt | awk -v cc=$cclass_room '{print $1,$2,cc,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/I.txt
					fi
					if [ $dd -eq "4" ]; then
						cat $HOME/.sa_dia/day_class/I.txt | awk -v cc=$cclass_room '{print $1,$2,$3,cc,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/I.txt
					fi
					if [ $dd -eq "5" ]; then
						cat $HOME/.sa_dia/day_class/I.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,cc,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/I.txt
					fi
					if [ $dd -eq "6" ]; then
						cat $HOME/.sa_dia/day_class/I.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,$5,cc}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/I.txt
					fi
				fi

				if [ $tt == "J" ]; then
					if [ $dd -eq "1" ]; then
						cat $HOME/.sa_dia/day_class/J.txt | awk -v cc=$cclass_room '{print cc,$2,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/J.txt
					fi
					if [ $dd -eq "2" ]; then
						cat $HOME/.sa_dia/day_class/J.txt | awk -v cc=$cclass_room '{print $1,cc,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/J.txt
					fi
					if [ $dd -eq "3" ]; then
						cat $HOME/.sa_dia/day_class/J.txt | awk -v cc=$cclass_room '{print $1,$2,cc,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/J.txt
					fi
					if [ $dd -eq "4" ]; then
						cat $HOME/.sa_dia/day_class/J.txt | awk -v cc=$cclass_room '{print $1,$2,$3,cc,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/J.txt
					fi
					if [ $dd -eq "5" ]; then
						cat $HOME/.sa_dia/day_class/J.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,cc,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/J.txt
					fi
					if [ $dd -eq "6" ]; then
						cat $HOME/.sa_dia/day_class/J.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,$5,cc}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/J.txt
					fi
				fi

				if [ $tt == "K" ]; then
					if [ $dd -eq "1" ]; then
						cat $HOME/.sa_dia/day_class/K.txt | awk -v cc=$cclass_room '{print cc,$2,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/K.txt
					fi
					if [ $dd -eq "2" ]; then
						cat $HOME/.sa_dia/day_class/K.txt | awk -v cc=$cclass_room '{print $1,cc,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/K.txt
					fi
					if [ $dd -eq "3" ]; then
						cat $HOME/.sa_dia/day_class/K.txt | awk -v cc=$cclass_room '{print $1,$2,cc,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/K.txt
					fi
					if [ $dd -eq "4" ]; then
						cat $HOME/.sa_dia/day_class/K.txt | awk -v cc=$cclass_room '{print $1,$2,$3,cc,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/K.txt
					fi
					if [ $dd -eq "5" ]; then
						cat $HOME/.sa_dia/day_class/K.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,cc,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/K.txt
					fi
					if [ $dd -eq "6" ]; then
						cat $HOME/.sa_dia/day_class/K.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,$5,cc}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/K.txt
					fi
				fi

				tt=`echo "$j" | head -c 3 | tail -c 1` ##time ###2
				if [ $tt == "N" ]; then
					if [ $dd -eq "1" ]; then
						cat $HOME/.sa_dia/day_class/N.txt | awk -v cc=$cclass_room '{print cc,$2,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/N.txt
					fi
					if [ $dd -eq "2" ]; then
						cat $HOME/.sa_dia/day_class/N.txt | awk -v cc=$cclass_room '{print $1,cc,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/N.txt
					fi
					if [ $dd -eq "3" ]; then
						cat $HOME/.sa_dia/day_class/N.txt | awk -v cc=$cclass_room '{print $1,$2,cc,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/N.txt
					fi
					if [ $dd -eq "4" ]; then
						cat $HOME/.sa_dia/day_class/N.txt | awk -v cc=$cclass_room '{print $1,$2,$3,cc,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/N.txt
					fi
					if [ $dd -eq "5" ]; then
						cat $HOME/.sa_dia/day_class/N.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,cc,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/N.txt
					fi
					if [ $dd -eq "6" ]; then
						cat $HOME/.sa_dia/day_class/N.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,$5,cc}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/N.txt
					fi
				fi

				if [ $tt == "A" ]; then
					if [ $dd -eq "1" ]; then
						cat $HOME/.sa_dia/day_class/A.txt | awk -v cc=$cclass_room '{print cc,$2,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/A.txt
					fi
					if [ $dd -eq "2" ]; then
						cat $HOME/.sa_dia/day_class/A.txt | awk -v cc=$cclass_room '{print $1,cc,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/A.txt
					fi
					if [ $dd -eq "3" ]; then
						cat $HOME/.sa_dia/day_class/A.txt | awk -v cc=$cclass_room '{print $1,$2,cc,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/A.txt
					fi
					if [ $dd -eq "4" ]; then
						cat $HOME/.sa_dia/day_class/A.txt | awk -v cc=$cclass_room '{print $1,$2,$3,cc,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/A.txt
					fi
					if [ $dd -eq "5" ]; then
						cat $HOME/.sa_dia/day_class/A.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,cc,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/A.txt
					fi
					if [ $dd -eq "6" ]; then
						cat $HOME/.sa_dia/day_class/A.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,$5,cc}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/A.txt
					fi
				fi

				if [ $tt == "B" ]; then
					if [ $dd -eq "1" ]; then
						cat $HOME/.sa_dia/day_class/B.txt | awk -v cc=$cclass_room '{print cc,$2,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/B.txt
					fi
					if [ $dd -eq "2" ]; then
						cat $HOME/.sa_dia/day_class/B.txt | awk -v cc=$cclass_room '{print $1,cc,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/B.txt
					fi
					if [ $dd -eq "3" ]; then
						cat $HOME/.sa_dia/day_class/B.txt | awk -v cc=$cclass_room '{print $1,$2,cc,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/B.txt
					fi
					if [ $dd -eq "4" ]; then
						cat $HOME/.sa_dia/day_class/B.txt | awk -v cc=$cclass_room '{print $1,$2,$3,cc,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/B.txt
					fi
					if [ $dd -eq "5" ]; then
						cat $HOME/.sa_dia/day_class/B.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,cc,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/B.txt
					fi
					if [ $dd -eq "6" ]; then
						cat $HOME/.sa_dia/day_class/B.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,$5,cc}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/B.txt
					fi
				fi

				if [ $tt == "C" ]; then
					if [ $dd -eq "1" ]; then
						cat $HOME/.sa_dia/day_class/C.txt | awk -v cc=$cclass_room '{print cc,$2,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/C.txt
					fi
					if [ $dd -eq "2" ]; then
						cat $HOME/.sa_dia/day_class/C.txt | awk -v cc=$cclass_room '{print $1,cc,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/C.txt
					fi
					if [ $dd -eq "3" ]; then
						cat $HOME/.sa_dia/day_class/C.txt | awk -v cc=$cclass_room '{print $1,$2,cc,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/C.txt
					fi
					if [ $dd -eq "4" ]; then
						cat $HOME/.sa_dia/day_class/C.txt | awk -v cc=$cclass_room '{print $1,$2,$3,cc,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/C.txt
					fi
					if [ $dd -eq "5" ]; then
						cat $HOME/.sa_dia/day_class/C.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,cc,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/C.txt
					fi
					if [ $dd -eq "6" ]; then
						cat $HOME/.sa_dia/day_class/C.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,$5,cc}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/C.txt
					fi
				fi

				if [ $tt == "D" ]; then
					if [ $dd -eq "1" ]; then
						cat $HOME/.sa_dia/day_class/D.txt | awk -v cc=$cclass_room '{print cc,$2,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/D.txt
					fi
					if [ $dd -eq "2" ]; then
						cat $HOME/.sa_dia/day_class/D.txt | awk -v cc=$cclass_room '{print $1,cc,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/D.txt
					fi
					if [ $dd -eq "3" ]; then
						cat $HOME/.sa_dia/day_class/D.txt | awk -v cc=$cclass_room '{print $1,$2,cc,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/D.txt
					fi
					if [ $dd -eq "4" ]; then
						cat $HOME/.sa_dia/day_class/D.txt | awk -v cc=$cclass_room '{print $1,$2,$3,cc,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/D.txt
					fi
					if [ $dd -eq "5" ]; then
						cat $HOME/.sa_dia/day_class/D.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,cc,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/D.txt
					fi
					if [ $dd -eq "6" ]; then
						cat $HOME/.sa_dia/day_class/D.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,$5,cc}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/D.txt
					fi
				fi

				if [ $tt == "X" ]; then
					if [ $dd -eq "1" ]; then
						cat $HOME/.sa_dia/day_class/X.txt | awk -v cc=$cclass_room '{print cc,$2,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/X.txt
					fi
					if [ $dd -eq "2" ]; then
						cat $HOME/.sa_dia/day_class/X.txt | awk -v cc=$cclass_room '{print $1,cc,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/X.txt
					fi
					if [ $dd -eq "3" ]; then
						cat $HOME/.sa_dia/day_class/X.txt | awk -v cc=$cclass_room '{print $1,$2,cc,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/X.txt
					fi
					if [ $dd -eq "4" ]; then
						cat $HOME/.sa_dia/day_class/X.txt | awk -v cc=$cclass_room '{print $1,$2,$3,cc,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/X.txt
					fi
					if [ $dd -eq "5" ]; then
						cat $HOME/.sa_dia/day_class/X.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,cc,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/X.txt
					fi
					if [ $dd -eq "6" ]; then
						cat $HOME/.sa_dia/day_class/X.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,$5,cc}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/X.txt
					fi
				fi

				if [ $tt == "E" ]; then
					if [ $dd -eq "1" ]; then
						cat $HOME/.sa_dia/day_class/E.txt | awk -v cc=$cclass_room '{print cc,$2,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/E.txt
					fi
					if [ $dd -eq "2" ]; then
						cat $HOME/.sa_dia/day_class/E.txt | awk -v cc=$cclass_room '{print $1,cc,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/E.txt
					fi
					if [ $dd -eq "3" ]; then
						cat $HOME/.sa_dia/day_class/E.txt | awk -v cc=$cclass_room '{print $1,$2,cc,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/E.txt
					fi
					if [ $dd -eq "4" ]; then
						cat $HOME/.sa_dia/day_class/E.txt | awk -v cc=$cclass_room '{print $1,$2,$3,cc,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/E.txt
					fi
					if [ $dd -eq "5" ]; then
						cat $HOME/.sa_dia/day_class/E.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,cc,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/E.txt
					fi
					if [ $dd -eq "6" ]; then
						cat $HOME/.sa_dia/day_class/E.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,$5,cc}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/E.txt
					fi
				fi

				if [ $tt == "F" ]; then
					if [ $dd -eq "1" ]; then
						cat $HOME/.sa_dia/day_class/F.txt | awk -v cc=$cclass_room '{print cc,$2,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/F.txt
					fi
					if [ $dd -eq "2" ]; then
						cat $HOME/.sa_dia/day_class/F.txt | awk -v cc=$cclass_room '{print $1,cc,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/F.txt
					fi
					if [ $dd -eq "3" ]; then
						cat $HOME/.sa_dia/day_class/F.txt | awk -v cc=$cclass_room '{print $1,$2,cc,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/F.txt
					fi
					if [ $dd -eq "4" ]; then
						cat $HOME/.sa_dia/day_class/F.txt | awk -v cc=$cclass_room '{print $1,$2,$3,cc,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/F.txt
					fi
					if [ $dd -eq "5" ]; then
						cat $HOME/.sa_dia/day_class/F.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,cc,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/F.txt
					fi
					if [ $dd -eq "6" ]; then
						cat $HOME/.sa_dia/day_class/F.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,$5,cc}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/F.txt
					fi
				fi

				if [ $tt == "G" ]; then
					if [ $dd -eq "1" ]; then
						cat $HOME/.sa_dia/day_class/G.txt | awk -v cc=$cclass_room '{print cc,$2,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/G.txt
					fi
					if [ $dd -eq "2" ]; then
						cat $HOME/.sa_dia/day_class/G.txt | awk -v cc=$cclass_room '{print $1,cc,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/G.txt
					fi
					if [ $dd -eq "3" ]; then
						cat $HOME/.sa_dia/day_class/G.txt | awk -v cc=$cclass_room '{print $1,$2,cc,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/G.txt
					fi
					if [ $dd -eq "4" ]; then
						cat $HOME/.sa_dia/day_class/G.txt | awk -v cc=$cclass_room '{print $1,$2,$3,cc,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/G.txt
					fi
					if [ $dd -eq "5" ]; then
						cat $HOME/.sa_dia/day_class/G.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,cc,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/G.txt
					fi
					if [ $dd -eq "6" ]; then
						cat $HOME/.sa_dia/day_class/G.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,$5,cc}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/G.txt
					fi
				fi

				if [ $tt == "H" ]; then
					if [ $dd -eq "1" ]; then
						cat $HOME/.sa_dia/day_class/H.txt | awk -v cc=$cclass_room '{print cc,$2,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/H.txt
					fi
					if [ $dd -eq "2" ]; then
						cat $HOME/.sa_dia/day_class/H.txt | awk -v cc=$cclass_room '{print $1,cc,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/H.txt
					fi
					if [ $dd -eq "3" ]; then
						cat $HOME/.sa_dia/day_class/H.txt | awk -v cc=$cclass_room '{print $1,$2,cc,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/H.txt
					fi
					if [ $dd -eq "4" ]; then
						cat $HOME/.sa_dia/day_class/H.txt | awk -v cc=$cclass_room '{print $1,$2,$3,cc,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/H.txt
					fi
					if [ $dd -eq "5" ]; then
						cat $HOME/.sa_dia/day_class/H.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,cc,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/H.txt
					fi
					if [ $dd -eq "6" ]; then
						cat $HOME/.sa_dia/day_class/H.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,$5,cc}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/H.txt
					fi
				fi

				if [ $tt == "Y" ]; then
					if [ $dd -eq "1" ]; then
						cat $HOME/.sa_dia/day_class/Y.txt | awk -v cc=$cclass_room '{print cc,$2,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/Y.txt
					fi
					if [ $dd -eq "2" ]; then
						cat $HOME/.sa_dia/day_class/Y.txt | awk -v cc=$cclass_room '{print $1,cc,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/Y.txt
					fi
					if [ $dd -eq "3" ]; then
						cat $HOME/.sa_dia/day_class/Y.txt | awk -v cc=$cclass_room '{print $1,$2,cc,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/Y.txt
					fi
					if [ $dd -eq "4" ]; then
						cat $HOME/.sa_dia/day_class/Y.txt | awk -v cc=$cclass_room '{print $1,$2,$3,cc,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/Y.txt
					fi
					if [ $dd -eq "5" ]; then
						cat $HOME/.sa_dia/day_class/Y.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,cc,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/Y.txt
					fi
					if [ $dd -eq "6" ]; then
						cat $HOME/.sa_dia/day_class/Y.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,$5,cc}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/Y.txt
					fi
				fi

				if [ $tt == "I" ]; then
					if [ $dd -eq "1" ]; then
						cat $HOME/.sa_dia/day_class/I.txt | awk -v cc=$cclass_room '{print cc,$2,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/I.txt
					fi
					if [ $dd -eq "2" ]; then
						cat $HOME/.sa_dia/day_class/I.txt | awk -v cc=$cclass_room '{print $1,cc,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/I.txt
					fi
					if [ $dd -eq "3" ]; then
						cat $HOME/.sa_dia/day_class/I.txt | awk -v cc=$cclass_room '{print $1,$2,cc,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/I.txt
					fi
					if [ $dd -eq "4" ]; then
						cat $HOME/.sa_dia/day_class/I.txt | awk -v cc=$cclass_room '{print $1,$2,$3,cc,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/I.txt
					fi
					if [ $dd -eq "5" ]; then
						cat $HOME/.sa_dia/day_class/I.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,cc,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/I.txt
					fi
					if [ $dd -eq "6" ]; then
						cat $HOME/.sa_dia/day_class/I.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,$5,cc}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/I.txt
					fi
				fi

				if [ $tt == "J" ]; then
					if [ $dd -eq "1" ]; then
						cat $HOME/.sa_dia/day_class/J.txt | awk -v cc=$cclass_room '{print cc,$2,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/J.txt
					fi
					if [ $dd -eq "2" ]; then
						cat $HOME/.sa_dia/day_class/J.txt | awk -v cc=$cclass_room '{print $1,cc,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/J.txt
					fi
					if [ $dd -eq "3" ]; then
						cat $HOME/.sa_dia/day_class/J.txt | awk -v cc=$cclass_room '{print $1,$2,cc,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/J.txt
					fi
					if [ $dd -eq "4" ]; then
						cat $HOME/.sa_dia/day_class/J.txt | awk -v cc=$cclass_room '{print $1,$2,$3,cc,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/J.txt
					fi
					if [ $dd -eq "5" ]; then
						cat $HOME/.sa_dia/day_class/J.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,cc,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/J.txt
					fi
					if [ $dd -eq "6" ]; then
						cat $HOME/.sa_dia/day_class/J.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,$5,cc}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/J.txt
					fi
				fi

				if [ $tt == "K" ]; then
					if [ $dd -eq "1" ]; then
						cat $HOME/.sa_dia/day_class/K.txt | awk -v cc=$cclass_room '{print cc,$2,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/K.txt
					fi
					if [ $dd -eq "2" ]; then
						cat $HOME/.sa_dia/day_class/K.txt | awk -v cc=$cclass_room '{print $1,cc,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/K.txt
					fi
					if [ $dd -eq "3" ]; then
						cat $HOME/.sa_dia/day_class/K.txt | awk -v cc=$cclass_room '{print $1,$2,cc,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/K.txt
					fi
					if [ $dd -eq "4" ]; then
						cat $HOME/.sa_dia/day_class/K.txt | awk -v cc=$cclass_room '{print $1,$2,$3,cc,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/K.txt
					fi
					if [ $dd -eq "5" ]; then
						cat $HOME/.sa_dia/day_class/K.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,cc,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/K.txt
					fi
					if [ $dd -eq "6" ]; then
						cat $HOME/.sa_dia/day_class/K.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,$5,cc}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/K.txt
					fi
				fi

				tt=`echo "$j" | head -c 4 | tail -c 1` ##time ### 3
				if [ $tt == "N" ]; then
					if [ $dd -eq "1" ]; then
						cat $HOME/.sa_dia/day_class/N.txt | awk -v cc=$cclass_room '{print cc,$2,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/N.txt
					fi
					if [ $dd -eq "2" ]; then
						cat $HOME/.sa_dia/day_class/N.txt | awk -v cc=$cclass_room '{print $1,cc,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/N.txt
					fi
					if [ $dd -eq "3" ]; then
						cat $HOME/.sa_dia/day_class/N.txt | awk -v cc=$cclass_room '{print $1,$2,cc,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/N.txt
					fi
					if [ $dd -eq "4" ]; then
						cat $HOME/.sa_dia/day_class/N.txt | awk -v cc=$cclass_room '{print $1,$2,$3,cc,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/N.txt
					fi
					if [ $dd -eq "5" ]; then
						cat $HOME/.sa_dia/day_class/N.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,cc,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/N.txt
					fi
					if [ $dd -eq "6" ]; then
						cat $HOME/.sa_dia/day_class/N.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,$5,cc}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/N.txt
					fi
				fi

				if [ $tt == "A" ]; then
					if [ $dd -eq "1" ]; then
						cat $HOME/.sa_dia/day_class/A.txt | awk -v cc=$cclass_room '{print cc,$2,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/A.txt
					fi
					if [ $dd -eq "2" ]; then
						cat $HOME/.sa_dia/day_class/A.txt | awk -v cc=$cclass_room '{print $1,cc,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/A.txt
					fi
					if [ $dd -eq "3" ]; then
						cat $HOME/.sa_dia/day_class/A.txt | awk -v cc=$cclass_room '{print $1,$2,cc,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/A.txt
					fi
					if [ $dd -eq "4" ]; then
						cat $HOME/.sa_dia/day_class/A.txt | awk -v cc=$cclass_room '{print $1,$2,$3,cc,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/A.txt
					fi
					if [ $dd -eq "5" ]; then
						cat $HOME/.sa_dia/day_class/A.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,cc,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/A.txt
					fi
					if [ $dd -eq "6" ]; then
						cat $HOME/.sa_dia/day_class/A.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,$5,cc}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/A.txt
					fi
				fi

				if [ $tt == "B" ]; then
					if [ $dd -eq "1" ]; then
						cat $HOME/.sa_dia/day_class/B.txt | awk -v cc=$cclass_room '{print cc,$2,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/B.txt
					fi
					if [ $dd -eq "2" ]; then
						cat $HOME/.sa_dia/day_class/B.txt | awk -v cc=$cclass_room '{print $1,cc,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/B.txt
					fi
					if [ $dd -eq "3" ]; then
						cat $HOME/.sa_dia/day_class/B.txt | awk -v cc=$cclass_room '{print $1,$2,cc,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/B.txt
					fi
					if [ $dd -eq "4" ]; then
						cat $HOME/.sa_dia/day_class/B.txt | awk -v cc=$cclass_room '{print $1,$2,$3,cc,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/B.txt
					fi
					if [ $dd -eq "5" ]; then
						cat $HOME/.sa_dia/day_class/B.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,cc,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/B.txt
					fi
					if [ $dd -eq "6" ]; then
						cat $HOME/.sa_dia/day_class/B.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,$5,cc}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/B.txt
					fi
				fi

				if [ $tt == "C" ]; then
					if [ $dd -eq "1" ]; then
						cat $HOME/.sa_dia/day_class/C.txt | awk -v cc=$cclass_room '{print cc,$2,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/C.txt
					fi
					if [ $dd -eq "2" ]; then
						cat $HOME/.sa_dia/day_class/C.txt | awk -v cc=$cclass_room '{print $1,cc,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/C.txt
					fi
					if [ $dd -eq "3" ]; then
						cat $HOME/.sa_dia/day_class/C.txt | awk -v cc=$cclass_room '{print $1,$2,cc,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/C.txt
					fi
					if [ $dd -eq "4" ]; then
						cat $HOME/.sa_dia/day_class/C.txt | awk -v cc=$cclass_room '{print $1,$2,$3,cc,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/C.txt
					fi
					if [ $dd -eq "5" ]; then
						cat $HOME/.sa_dia/day_class/C.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,cc,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/C.txt
					fi
					if [ $dd -eq "6" ]; then
						cat $HOME/.sa_dia/day_class/C.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,$5,cc}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/C.txt
					fi
				fi

				if [ $tt == "D" ]; then
					if [ $dd -eq "1" ]; then
						cat $HOME/.sa_dia/day_class/D.txt | awk -v cc=$cclass_room '{print cc,$2,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/D.txt
					fi
					if [ $dd -eq "2" ]; then
						cat $HOME/.sa_dia/day_class/D.txt | awk -v cc=$cclass_room '{print $1,cc,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/D.txt
					fi
					if [ $dd -eq "3" ]; then
						cat $HOME/.sa_dia/day_class/D.txt | awk -v cc=$cclass_room '{print $1,$2,cc,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/D.txt
					fi
					if [ $dd -eq "4" ]; then
						cat $HOME/.sa_dia/day_class/D.txt | awk -v cc=$cclass_room '{print $1,$2,$3,cc,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/D.txt
					fi
					if [ $dd -eq "5" ]; then
						cat $HOME/.sa_dia/day_class/D.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,cc,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/D.txt
					fi
					if [ $dd -eq "6" ]; then
						cat $HOME/.sa_dia/day_class/D.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,$5,cc}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/D.txt
					fi
				fi

				if [ $tt == "X" ]; then
					if [ $dd -eq "1" ]; then
						cat $HOME/.sa_dia/day_class/X.txt | awk -v cc=$cclass_room '{print cc,$2,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/X.txt
					fi
					if [ $dd -eq "2" ]; then
						cat $HOME/.sa_dia/day_class/X.txt | awk -v cc=$cclass_room '{print $1,cc,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/X.txt
					fi
					if [ $dd -eq "3" ]; then
						cat $HOME/.sa_dia/day_class/X.txt | awk -v cc=$cclass_room '{print $1,$2,cc,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/X.txt
					fi
					if [ $dd -eq "4" ]; then
						cat $HOME/.sa_dia/day_class/X.txt | awk -v cc=$cclass_room '{print $1,$2,$3,cc,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/X.txt
					fi
					if [ $dd -eq "5" ]; then
						cat $HOME/.sa_dia/day_class/X.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,cc,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/X.txt
					fi
					if [ $dd -eq "6" ]; then
						cat $HOME/.sa_dia/day_class/X.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,$5,cc}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/X.txt
					fi
				fi

				if [ $tt == "E" ]; then
					if [ $dd -eq "1" ]; then
						cat $HOME/.sa_dia/day_class/E.txt | awk -v cc=$cclass_room '{print cc,$2,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/E.txt
					fi
					if [ $dd -eq "2" ]; then
						cat $HOME/.sa_dia/day_class/E.txt | awk -v cc=$cclass_room '{print $1,cc,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/E.txt
					fi
					if [ $dd -eq "3" ]; then
						cat $HOME/.sa_dia/day_class/E.txt | awk -v cc=$cclass_room '{print $1,$2,cc,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/E.txt
					fi
					if [ $dd -eq "4" ]; then
						cat $HOME/.sa_dia/day_class/E.txt | awk -v cc=$cclass_room '{print $1,$2,$3,cc,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/E.txt
					fi
					if [ $dd -eq "5" ]; then
						cat $HOME/.sa_dia/day_class/E.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,cc,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/E.txt
					fi
					if [ $dd -eq "6" ]; then
						cat $HOME/.sa_dia/day_class/E.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,$5,cc}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/E.txt
					fi
				fi

				if [ $tt == "F" ]; then
					if [ $dd -eq "1" ]; then
						cat $HOME/.sa_dia/day_class/F.txt | awk -v cc=$cclass_room '{print cc,$2,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/F.txt
					fi
					if [ $dd -eq "2" ]; then
						cat $HOME/.sa_dia/day_class/F.txt | awk -v cc=$cclass_room '{print $1,cc,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/F.txt
					fi
					if [ $dd -eq "3" ]; then
						cat $HOME/.sa_dia/day_class/F.txt | awk -v cc=$cclass_room '{print $1,$2,cc,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/F.txt
					fi
					if [ $dd -eq "4" ]; then
						cat $HOME/.sa_dia/day_class/F.txt | awk -v cc=$cclass_room '{print $1,$2,$3,cc,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/F.txt
					fi
					if [ $dd -eq "5" ]; then
						cat $HOME/.sa_dia/day_class/F.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,cc,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/F.txt
					fi
					if [ $dd -eq "6" ]; then
						cat $HOME/.sa_dia/day_class/F.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,$5,cc}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/F.txt
					fi
				fi

				if [ $tt == "G" ]; then
					if [ $dd -eq "1" ]; then
						cat $HOME/.sa_dia/day_class/G.txt | awk -v cc=$cclass_room '{print cc,$2,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/G.txt
					fi
					if [ $dd -eq "2" ]; then
						cat $HOME/.sa_dia/day_class/G.txt | awk -v cc=$cclass_room '{print $1,cc,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/G.txt
					fi
					if [ $dd -eq "3" ]; then
						cat $HOME/.sa_dia/day_class/G.txt | awk -v cc=$cclass_room '{print $1,$2,cc,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/G.txt
					fi
					if [ $dd -eq "4" ]; then
						cat $HOME/.sa_dia/day_class/G.txt | awk -v cc=$cclass_room '{print $1,$2,$3,cc,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/G.txt
					fi
					if [ $dd -eq "5" ]; then
						cat $HOME/.sa_dia/day_class/G.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,cc,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/G.txt
					fi
					if [ $dd -eq "6" ]; then
						cat $HOME/.sa_dia/day_class/G.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,$5,cc}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/G.txt
					fi
				fi

				if [ $tt == "H" ]; then
					if [ $dd -eq "1" ]; then
						cat $HOME/.sa_dia/day_class/H.txt | awk -v cc=$cclass_room '{print cc,$2,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/H.txt
					fi
					if [ $dd -eq "2" ]; then
						cat $HOME/.sa_dia/day_class/H.txt | awk -v cc=$cclass_room '{print $1,cc,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/H.txt
					fi
					if [ $dd -eq "3" ]; then
						cat $HOME/.sa_dia/day_class/H.txt | awk -v cc=$cclass_room '{print $1,$2,cc,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/H.txt
					fi
					if [ $dd -eq "4" ]; then
						cat $HOME/.sa_dia/day_class/H.txt | awk -v cc=$cclass_room '{print $1,$2,$3,cc,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/H.txt
					fi
					if [ $dd -eq "5" ]; then
						cat $HOME/.sa_dia/day_class/H.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,cc,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/H.txt
					fi
					if [ $dd -eq "6" ]; then
						cat $HOME/.sa_dia/day_class/H.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,$5,cc}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/H.txt
					fi
				fi

				if [ $tt == "Y" ]; then
					if [ $dd -eq "1" ]; then
						cat $HOME/.sa_dia/day_class/Y.txt | awk -v cc=$cclass_room '{print cc,$2,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/Y.txt
					fi
					if [ $dd -eq "2" ]; then
						cat $HOME/.sa_dia/day_class/Y.txt | awk -v cc=$cclass_room '{print $1,cc,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/Y.txt
					fi
					if [ $dd -eq "3" ]; then
						cat $HOME/.sa_dia/day_class/Y.txt | awk -v cc=$cclass_room '{print $1,$2,cc,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/Y.txt
					fi
					if [ $dd -eq "4" ]; then
						cat $HOME/.sa_dia/day_class/Y.txt | awk -v cc=$cclass_room '{print $1,$2,$3,cc,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/Y.txt
					fi
					if [ $dd -eq "5" ]; then
						cat $HOME/.sa_dia/day_class/Y.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,cc,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/Y.txt
					fi
					if [ $dd -eq "6" ]; then
						cat $HOME/.sa_dia/day_class/Y.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,$5,cc}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/Y.txt
					fi
				fi

				if [ $tt == "I" ]; then
					if [ $dd -eq "1" ]; then
						cat $HOME/.sa_dia/day_class/I.txt | awk -v cc=$cclass_room '{print cc,$2,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/I.txt
					fi
					if [ $dd -eq "2" ]; then
						cat $HOME/.sa_dia/day_class/I.txt | awk -v cc=$cclass_room '{print $1,cc,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/I.txt
					fi
					if [ $dd -eq "3" ]; then
						cat $HOME/.sa_dia/day_class/I.txt | awk -v cc=$cclass_room '{print $1,$2,cc,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/I.txt
					fi
					if [ $dd -eq "4" ]; then
						cat $HOME/.sa_dia/day_class/I.txt | awk -v cc=$cclass_room '{print $1,$2,$3,cc,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/I.txt
					fi
					if [ $dd -eq "5" ]; then
						cat $HOME/.sa_dia/day_class/I.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,cc,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/I.txt
					fi
					if [ $dd -eq "6" ]; then
						cat $HOME/.sa_dia/day_class/I.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,$5,cc}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/I.txt
					fi
				fi

				if [ $tt == "J" ]; then
					if [ $dd -eq "1" ]; then
						cat $HOME/.sa_dia/day_class/J.txt | awk -v cc=$cclass_room '{print cc,$2,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/J.txt
					fi
					if [ $dd -eq "2" ]; then
						cat $HOME/.sa_dia/day_class/J.txt | awk -v cc=$cclass_room '{print $1,cc,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/J.txt
					fi
					if [ $dd -eq "3" ]; then
						cat $HOME/.sa_dia/day_class/J.txt | awk -v cc=$cclass_room '{print $1,$2,cc,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/J.txt
					fi
					if [ $dd -eq "4" ]; then
						cat $HOME/.sa_dia/day_class/J.txt | awk -v cc=$cclass_room '{print $1,$2,$3,cc,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/J.txt
					fi
					if [ $dd -eq "5" ]; then
						cat $HOME/.sa_dia/day_class/J.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,cc,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/J.txt
					fi
					if [ $dd -eq "6" ]; then
						cat $HOME/.sa_dia/day_class/J.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,$5,cc}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/J.txt
					fi
				fi

				if [ $tt == "K" ]; then
					if [ $dd -eq "1" ]; then
						cat $HOME/.sa_dia/day_class/K.txt | awk -v cc=$cclass_room '{print cc,$2,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/K.txt
					fi
					if [ $dd -eq "2" ]; then
						cat $HOME/.sa_dia/day_class/K.txt | awk -v cc=$cclass_room '{print $1,cc,$3,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/K.txt
					fi
					if [ $dd -eq "3" ]; then
						cat $HOME/.sa_dia/day_class/K.txt | awk -v cc=$cclass_room '{print $1,$2,cc,$4,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/K.txt
					fi
					if [ $dd -eq "4" ]; then
						cat $HOME/.sa_dia/day_class/K.txt | awk -v cc=$cclass_room '{print $1,$2,$3,cc,$5,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/K.txt
					fi
					if [ $dd -eq "5" ]; then
						cat $HOME/.sa_dia/day_class/K.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,cc,$6}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/K.txt
					fi
					if [ $dd -eq "6" ]; then
						cat $HOME/.sa_dia/day_class/K.txt | awk -v cc=$cclass_room '{print $1,$2,$3,$4,$5,cc}' > $HOME/.sa_dia/day_class/tmp_insert.txt
						cat $HOME/.sa_dia/day_class/tmp_insert.txt > $HOME/.sa_dia/day_class/K.txt
					fi
				fi

			fi

		done

	done





	cat $HOME/.sa_dia/day_class/N.txt > $HOME/.sa_dia/ttb.txt
	cat $HOME/.sa_dia/day_class/A.txt >> $HOME/.sa_dia/ttb.txt
	cat $HOME/.sa_dia/day_class/B.txt >> $HOME/.sa_dia/ttb.txt
	cat $HOME/.sa_dia/day_class/C.txt >> $HOME/.sa_dia/ttb.txt
	cat $HOME/.sa_dia/day_class/D.txt >> $HOME/.sa_dia/ttb.txt
	cat $HOME/.sa_dia/day_class/X.txt >> $HOME/.sa_dia/ttb.txt
	cat $HOME/.sa_dia/day_class/E.txt >> $HOME/.sa_dia/ttb.txt
	cat $HOME/.sa_dia/day_class/F.txt >> $HOME/.sa_dia/ttb.txt
	cat $HOME/.sa_dia/day_class/G.txt >> $HOME/.sa_dia/ttb.txt
	cat $HOME/.sa_dia/day_class/H.txt >> $HOME/.sa_dia/ttb.txt
	cat $HOME/.sa_dia/day_class/Y.txt >> $HOME/.sa_dia/ttb.txt
	cat $HOME/.sa_dia/day_class/I.txt >> $HOME/.sa_dia/ttb.txt
	cat $HOME/.sa_dia/day_class/J.txt >> $HOME/.sa_dia/ttb.txt
	cat $HOME/.sa_dia/day_class/K.txt >> $HOME/.sa_dia/ttb.txt

	cat $HOME/.sa_dia/ttb.txt | column -tx > $HOME/.sa_dia/output_op1.txt
	#cat $HOME/.sa_dia/output_op1.txt

	####################################################stupid second times



	cat $HOME/.sa_dia/day_class/A.txt | awk '{print $1,$2,$3,$4,$5,$6}'  > $HOME/.sa_dia/ttb.txt
	cat $HOME/.sa_dia/day_class/B.txt | awk '{print $1,$2,$3,$4,$5,$6}' >> $HOME/.sa_dia/ttb.txt
	cat $HOME/.sa_dia/day_class/C.txt | awk '{print $1,$2,$3,$4,$5,$6}' >> $HOME/.sa_dia/ttb.txt
	cat $HOME/.sa_dia/day_class/D.txt | awk '{print $1,$2,$3,$4,$5,$6}' >> $HOME/.sa_dia/ttb.txt
	cat $HOME/.sa_dia/day_class/E.txt | awk '{print $1,$2,$3,$4,$5,$6}' >> $HOME/.sa_dia/ttb.txt
	cat $HOME/.sa_dia/day_class/F.txt | awk '{print $1,$2,$3,$4,$5,$6}' >> $HOME/.sa_dia/ttb.txt
	cat $HOME/.sa_dia/day_class/G.txt | awk '{print $1,$2,$3,$4,$5,$6}' >> $HOME/.sa_dia/ttb.txt
	cat $HOME/.sa_dia/day_class/H.txt | awk '{print $1,$2,$3,$4,$5,$6}' >> $HOME/.sa_dia/ttb.txt

	cat $HOME/.sa_dia/ttb.txt | column -tx > $HOME/.sa_dia/output_op2.txt
	#cat $HOME/.sa_dia/output_op2.txt
	#write_class
	ttable
}








welcome




