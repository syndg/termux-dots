for i in ~/mydots/*; do
    if [ -d $i ]; then
        stow $(basename $i)
    if $SCRIPT_DEBUG; then echo "$(basename $i) stowed."; fi
    fi
done
