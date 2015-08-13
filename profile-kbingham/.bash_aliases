function include_d {
		dir=$1
		if [ -d $HOME/.$dir.d -a -r $HOME/.$dir.d -a -x $HOME/.$dir.d ]; then
				for i in $HOME/.$dir.d/*.sh; do
						 . $i
				done
		fi
}


# Alias definitions.
include_d bash_aliases
