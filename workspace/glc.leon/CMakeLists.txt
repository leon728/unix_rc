cmake_minimum_required(VERSION 3.2)
project(glc)

#---- build 32-bit target on 64-bit machine
set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_VERSION 1)
set(CMAKE_SYSTEM_PROCESSOR "i686")
#set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -m32" CACHE STRING "c++ flags")
set(CMAKE_C_FLAGS   "${CMAKE_C_FLAGS} -m32" CACHE STRING "c flags")

#----
#set(CMAKE_VERBOSE_MAKEFILE ON)
#set(CMAKE_BUILD_TYPE Debug)
#message(${new_list})
#add_definitions("-DKKK=123 -DSSS=ABC")
#add_definitions(-DWITH_OPENCV2)
#FILE(GLOB SOURCE_FILES *.c)
#AUX_SOURCE_DIRECTORY(private/common SOURCE_FILES)
#AUX_SOURCE_DIRECTORY(private/product SOURCE_FILES)
#add_definitions("-DDEBUG")

#---- list of include directories and c files
file(STRINGS incdir.txt INCDIR)
include_directories(
	${INCDIR}
	private/include
)

#file(STRINGS cfiles.txt C_FILES)
FILE(GLOB_RECURSE C_FILES
	private/lcoam/*.c
	private/common/*.c
	private/xlcman/*.c
	private/lib/*.c
	private/product/*.c
	private/thirdparty/sdk-xgs-robo-6.3.9/src/customer/*.c
)

#---- add c files into a dummy target so that CLion will parse them
#add_executable(glc ${C_FILES})
add_executable(mmm ${C_FILES})

#---- add our custom target here, so that we can compile and run/debug
#add_custom_target(glc COMMAND
#	make -C ${glc_SOURCE_DIR} -f Makefile clicommand
#	CLION_EXE_DIR=${PROJECT_BINARY_DIR}
#)

#add_custom_target(glc COMMAND make -C ${glc_SOURCE_DIR} -f Makefile clicommand)
#add_custom_target(glc COMMAND make -C ${glc_SOURCE_DIR} loopguard)
#add_custom_target(glc COMMAND EXTRA_FLAG=-DDEBUG make -C ${glc_SOURCE_DIR} loopguard)

#set_target_properties(glc PROPERTIES COMPILE_FLAGS "-m32" LINK_FLAGS "-m32")
