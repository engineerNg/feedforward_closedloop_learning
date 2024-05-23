# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.28

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/kinsley/OneDrive/study/final_project/feedforward_closedloop_learning

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/kinsley/OneDrive/study/final_project/feedforward_closedloop_learning

# Include any dependencies generated for this target.
include tests_c/CMakeFiles/test_fcl.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include tests_c/CMakeFiles/test_fcl.dir/compiler_depend.make

# Include the progress variables for this target.
include tests_c/CMakeFiles/test_fcl.dir/progress.make

# Include the compile flags for this target's objects.
include tests_c/CMakeFiles/test_fcl.dir/flags.make

tests_c/CMakeFiles/test_fcl.dir/test_fcl.cpp.o: tests_c/CMakeFiles/test_fcl.dir/flags.make
tests_c/CMakeFiles/test_fcl.dir/test_fcl.cpp.o: tests_c/test_fcl.cpp
tests_c/CMakeFiles/test_fcl.dir/test_fcl.cpp.o: tests_c/CMakeFiles/test_fcl.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=/home/kinsley/OneDrive/study/final_project/feedforward_closedloop_learning/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object tests_c/CMakeFiles/test_fcl.dir/test_fcl.cpp.o"
	cd /home/kinsley/OneDrive/study/final_project/feedforward_closedloop_learning/tests_c && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT tests_c/CMakeFiles/test_fcl.dir/test_fcl.cpp.o -MF CMakeFiles/test_fcl.dir/test_fcl.cpp.o.d -o CMakeFiles/test_fcl.dir/test_fcl.cpp.o -c /home/kinsley/OneDrive/study/final_project/feedforward_closedloop_learning/tests_c/test_fcl.cpp

tests_c/CMakeFiles/test_fcl.dir/test_fcl.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing CXX source to CMakeFiles/test_fcl.dir/test_fcl.cpp.i"
	cd /home/kinsley/OneDrive/study/final_project/feedforward_closedloop_learning/tests_c && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/kinsley/OneDrive/study/final_project/feedforward_closedloop_learning/tests_c/test_fcl.cpp > CMakeFiles/test_fcl.dir/test_fcl.cpp.i

tests_c/CMakeFiles/test_fcl.dir/test_fcl.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling CXX source to assembly CMakeFiles/test_fcl.dir/test_fcl.cpp.s"
	cd /home/kinsley/OneDrive/study/final_project/feedforward_closedloop_learning/tests_c && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/kinsley/OneDrive/study/final_project/feedforward_closedloop_learning/tests_c/test_fcl.cpp -o CMakeFiles/test_fcl.dir/test_fcl.cpp.s

# Object files for target test_fcl
test_fcl_OBJECTS = \
"CMakeFiles/test_fcl.dir/test_fcl.cpp.o"

# External object files for target test_fcl
test_fcl_EXTERNAL_OBJECTS =

tests_c/test_fcl: tests_c/CMakeFiles/test_fcl.dir/test_fcl.cpp.o
tests_c/test_fcl: tests_c/CMakeFiles/test_fcl.dir/build.make
tests_c/test_fcl: libfcl_static.a
tests_c/test_fcl: tests_c/CMakeFiles/test_fcl.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --bold --progress-dir=/home/kinsley/OneDrive/study/final_project/feedforward_closedloop_learning/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable test_fcl"
	cd /home/kinsley/OneDrive/study/final_project/feedforward_closedloop_learning/tests_c && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/test_fcl.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
tests_c/CMakeFiles/test_fcl.dir/build: tests_c/test_fcl
.PHONY : tests_c/CMakeFiles/test_fcl.dir/build

tests_c/CMakeFiles/test_fcl.dir/clean:
	cd /home/kinsley/OneDrive/study/final_project/feedforward_closedloop_learning/tests_c && $(CMAKE_COMMAND) -P CMakeFiles/test_fcl.dir/cmake_clean.cmake
.PHONY : tests_c/CMakeFiles/test_fcl.dir/clean

tests_c/CMakeFiles/test_fcl.dir/depend:
	cd /home/kinsley/OneDrive/study/final_project/feedforward_closedloop_learning && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/kinsley/OneDrive/study/final_project/feedforward_closedloop_learning /home/kinsley/OneDrive/study/final_project/feedforward_closedloop_learning/tests_c /home/kinsley/OneDrive/study/final_project/feedforward_closedloop_learning /home/kinsley/OneDrive/study/final_project/feedforward_closedloop_learning/tests_c /home/kinsley/OneDrive/study/final_project/feedforward_closedloop_learning/tests_c/CMakeFiles/test_fcl.dir/DependInfo.cmake "--color=$(COLOR)"
.PHONY : tests_c/CMakeFiles/test_fcl.dir/depend

