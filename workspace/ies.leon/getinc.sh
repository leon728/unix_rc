#!/bin/sh

rm -f incdir.txt
find private -name '*.h' -exec dirname '{}' + | sort | uniq >> incdir.txt
find product/IES5206/src -name '*.h' -exec dirname '{}' + | sort | uniq >> incdir.txt
