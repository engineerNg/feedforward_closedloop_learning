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
CMAKE_SOURCE_DIR = /home/kinsley/github_project/feedforward_closedloop_learning

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/kinsley/github_project/feedforward_closedloop_learning

# Include any dependencies generated for this target.
include tests_c/CMakeFiles/test_bandpass.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include tests_c/CMakeFiles/test_bandpass.dir/compiler_depend.make

# Include the progress variables for this target.
include tests_c/CMakeFiles/test_bandpass.dir/progress.make

# Include the compile flags for this target's objects.
include tests_c/CMakeFiles/test_bandpass.dir/flags.make

tests_c/CMakeFiles/test_bandpass.dir/test_bandpass.cpp.o: tests_c/CMakeFiles/test_bandpass.dir/flags.make
tests_c/CMakeFiles/test_bandpass.dir/test_bandpass.cpp.o: tests_c/test_bandpass.cpp
tests_c/CMakeFiles/test_bandpass.dir/test_bandpass.cpp.o: tests_c/CMakeFiles/test_bandpass.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=/home/kinsley/github_project/feedforward_closedloop_learning/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object tests_c/CMakeFiles/test_bandpass.dir/test_bandpass.cpp.o"
	cd /home/kinsley/github_project/feedforward_closedloop_learning/tests_c && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT tests_c/CMakeFiles/test_bandpass.dir/test_bandpass.cpp.o -MF CMakeFiles/test_bandpass.dir/test_bandpass.cpp.o.d -o CMakeFiles/test_bandpass.dir/test_bandpass.cpp.o -c /home/kinsley/github_project/feedforward_closedloop_learning/tests_c/test_bandpass.cpp

tests_c/CMakeFiles/test_bandpass.dir/test_bandpass.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing CXX source to CMakeFiles/test_bandpass.dir/test_bandpass.cpp.i"
	cd /home/kinsley/github_project/feedforward_closedloop_learning/tests_c && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/kinsley/github_project/feedforward_closedloop_learning/tests_c/test_bandpass.cpp > CMakeFiles/test_bandpass.dir/test_bandpass.cpp.i

tests_c/CMakeFiles/test_bandpass.dir/test_bandpass.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling CXX source to assembly CMakeFiles/test_bandpass.dir/test_bandpass.cpp.s"
	cd /home/kinsley/github_project/feedforward_closedloop_learning/tests_c && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/kinsley/github_project/feedforward_closedloop_learning/tests_c/test_bandpass.cpp -o CMakeFiles/test_bandpass.dir/test_bandpass.cpp.s

# Object files for target test_bandpass
test_bandpass_OBJECTS = \
"CMakeFiles/test_bandpass.dir/test_bandpass.cpp.o"

# External object files for target test_bandpass
test_bandpass_EXTERNAL_OBJECTS =

tests_c/test_bandpass: tests_c/CMakeFiles/test_bandpass.dir/test_bandpass.cpp.o
tests_c/test_bandpass: tests_c/CMakeFiles/test_bandpass.dir/build.make
tests_c/test_bandpass: libfcl_static.a
tests_c/test_bandpass: tests_c/CMakeFiles/test_bandpass.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --bold --progress-dir=/home/kinsley/github_project/feedforward_closedloop_learning/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable test_bandpass"
	cd /home/kinsley/github_project/feedforward_closedloop_learning/tests_c && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/test_bandpass.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
tests_c/CMakeFiles/test_bandpass.dir/build: tests_c/test_bandpass
.PHONY : tests_c/CMakeFiles/test_bandpass.dir/build

tests_c/CMakeFiles/test_bandpass.dir/clean:
	cd /home/kinsley/github_project/feedforward_closedloop_learning/tests_c && $(CMAKE_COMMAND) -P CMakeFiles/test_bandpass.dir/cmake_clean.cmake
.PHONY : tests_c/CMakeFiles/test_bandpass.dir/clean

tests_c/CMakeFiles/test_bandpass.dir/depend:
	cd /home/kinsley/github_project/feedforward_closedloop_learning && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/kinsley/github_project/feedforward_closedloop_learning /home/kinsley/github_project/feedforward_closedloop_learning/tests_c /home/kinsley/github_project/feedforward_closedloop_learning /home/kinsley/github_project/feedforward_closedloop_learning/tests_c /home/kinsley/github_project/feedforward_closedloop_learning/tests_c/CMakeFiles/test_bandpass.dir/DependInfo.cmake "--color=$(COLOR)"
.PHONY : tests_c/CMakeFiles/test_bandpass.dir/depend
