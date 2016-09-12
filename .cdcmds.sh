# http://softwareengisneering.blogspot.tw/2009/11/nicer-pushd-popd-and-dirs.html
# https://gist.github.com/mbadran/130469
# http://thrysoee.dk/pushd/
# http://www.thegeekstuff.com/2008/10/6-awesome-linux-cd-command-hacks-productivity-tip3-for-geeks/

function _cd {
    # typing just `_cd` will take you $HOME ;)
    if [ "$1" == "" ]; then
        pushd "$HOME" > /dev/null
        #builtin cd ~

    # use `_cd -` to visit previous directory
    elif [ "$1" == "-" ]; then
        #pushd $OLDPWD > /dev/null
        #builtin cd -
        # "cd -" as "cd -1"
   		eval tdir=~1
		pushd $tdir > /dev/null
		popd -n +2 > /dev/null

    # use `_cd -n` to go n directories back in history
    elif [[ "$1" =~ ^-[0-9]+$ ]]; then
    
		if [ 1 == 0 ]; then
		ds=(`command dirs -l`)
		i=0
		while [ "${ds[$i]}" != "" ]; do
			#echo $i: ${ds[$i]};
			if [ $i == ${1/-/} ]; then
				pushd ${ds[$i]} > /dev/null
				#builtin cd ${ds[$i]}
				break;
			fi
			i=$((i+1));
		done
		fi
		
		eval tdir=~${1/-/}
		pushd $tdir > /dev/null
		popd -n +$((${1/-/} + 1)) > /dev/null
		
		# we are not using this, because it will pop out all previous items in stack
		if [ 1 == 0 ]; then
	    for i in `seq 1 ${1/-/}`; do
            popd > /dev/null
        done
        fi

    # use `_cd -- <path>` if your path begins with a dash
    elif [ "$1" == "--" ]; then
        shift
        pushd -- "$@" > /dev/null

    # basic case: move to a dir and add it to history
    else
        pushd "$@" > /dev/null
    fi
    
	if [ 1 == 1 ]; then
	# remove duplicate dirs
	#echo pp: $PWD
	LEN=${#DIRSTACK[@]}
	for ((i=LEN-1; i > 0 ; i--)); do
		eval p=~$i
		#echo = $p =
		if [ "$p" = "$PWD" ]; then
			popd -n +$i > /dev/null
			#break
		fi
	done
	fi
}

# replace standard `cd` with enhanced version, ensure tab-completion works
alias cd=_cd
complete -d cd

# autocd will not use our _cd, so disabling it
# show
#shopt autocd
# set
#shopt -s autocd

alias d='dirs -v | head -10'

alias ..='_cd ..'
alias ...='_cd ../..'
alias ....='_cd ../../..'
alias .....='_cd ../../../..'
alias ......='_cd ../../../../..'
alias .......='_cd ../../../../../..'

alias .2='_cd ..'
alias .3='_cd ../..'
alias .4='_cd ../../..'
alias .5='_cd ../../../..'
alias .6='_cd ../../../../..'
alias .7='_cd ../../../../../..'

alias ..2='_cd ../..'
alias ..3='_cd ../../..'
alias ..4='_cd ../../../..'
alias ..5='_cd ../../../../..'
alias ..6='_cd ../../../../../..'

alias ~='_cd ~'
alias -- -='_cd -'
alias 1='_cd -'
alias 2='_cd -2'
alias 3='_cd -3'
alias 4='_cd -4'
alias 5='_cd -5'
alias 6='_cd -6'
alias 7='_cd -7'
alias 8='_cd -8'
alias 9='_cd -9'
