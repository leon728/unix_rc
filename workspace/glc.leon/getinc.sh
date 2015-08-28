#!/bin/sh

rm -f incdir.txt
find private/lcoam -name '*.h' -exec dirname '{}' + | sort | uniq >> incdir.txt
find private/common -name '*.h' -exec dirname '{}' + | sort | uniq >> incdir.txt
find private/xlcman -name '*.h' -exec dirname '{}' + | sort | uniq >> incdir.txt
find private/lib -name '*.h' -exec dirname '{}' + | sort | uniq >> incdir.txt
find private/include -name '*.h' -exec dirname '{}' + | sort | uniq >> incdir.txt
find private/product -name '*.h' -exec dirname '{}' + | sort | uniq >> incdir.txt
find private/thirdparty/sdk-xgs-robo-6.3.9/include/customer -name '*.h' -exec dirname '{}' + | sort | uniq >> incdir.txt
