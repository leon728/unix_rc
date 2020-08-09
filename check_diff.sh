#fd -tf -d1 -uu -x sh -c "diff -q {} ../{}"

files=$(fd -tf -d1 -uu)
for f in $files; do
  msg=$(diff -q $f ~/$f 2>&1)
  rc=$?

  [ $rc -eq 0 ] && continue

  if [ $rc -eq 1 ]; then
    echo "==== $f : ~/$f ===="
	colordiff $f ../$f
  fi

  if [ $rc -eq 2 -a "$1" != "" ]; then
    echo $msg
  fi
done
