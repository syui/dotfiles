function qfcz (){
zdirselect=`z | sort -g -r | peco | cut -d  ' ' -f 2- | sed 's/ //g'`
if [ `echo "$LBUFFER" | wc -w | tr -d ' '` -eq 0 ];then
	cd $zdirselect
	ls -slhAF
	#gls -slhAF --color
	#if type precmd > /dev/null 2>&1; then
        #    precmd
        #fi
	#local precmd_func
        #for precmd_func in $precmd_functions; do
        #    $precmd_func
        #done
	zle reset-prompt
else
	LBUFFER+="$zdirselect"
fi
#CURSOR=$#BUFFER
#cd $zdirselect
}
zle -N qfcz
bindkey '^j' qfcz

#function qfcz-select (){
#com='$SHELL -c "ls -AF . | grep / "'
#while [ $? = 0 ]
#do
#	cdir=`eval $com | peco`
#	if [ $? = 0 ];then
#		LBUFFER+="$cdir"
#		#CURSOR=$#BUFFER
#		cd $cdir
#		eval $com
#	else
#		break
#	fi
#done
#zle reset-prompt
#}
#zle -N qfcz-select
#bindkey '^f' qfcz-select
