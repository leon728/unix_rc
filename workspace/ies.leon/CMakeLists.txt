cmake_minimum_required(VERSION 3.2)
project(ies)

#set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")

#set(SOURCE_FILES main.cpp)
#add_executable(ies ${SOURCE_FILES})

#---- list of include directories and c files
file(STRINGS incdir.txt INCDIR)
include_directories(
	${INCDIR}
	private/include
)

#file(STRINGS cfiles.txt C_FILES)
FILE(GLOB_RECURSE C_FILES
	private/*.c
	product/IES5206/src/*.c
)

add_definitions(
	"-DOAM"
)

#---- add c files into a dummy target so that CLion will parse them
#add_executable(glc_my ${C_FILES})
add_executable(mmm ${C_FILES})
