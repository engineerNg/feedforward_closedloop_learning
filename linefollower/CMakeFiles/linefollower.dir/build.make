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
include linefollower/CMakeFiles/linefollower.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include linefollower/CMakeFiles/linefollower.dir/compiler_depend.make

# Include the progress variables for this target.
include linefollower/CMakeFiles/linefollower.dir/progress.make

# Include the compile flags for this target's objects.
include linefollower/CMakeFiles/linefollower.dir/flags.make

linefollower/linefollower_autogen/timestamp: /usr/lib64/qt5/bin/moc
linefollower/linefollower_autogen/timestamp: /usr/lib64/qt5/bin/uic
linefollower/linefollower_autogen/timestamp: linefollower/CMakeFiles/linefollower.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --blue --bold --progress-dir=/home/kinsley/github_project/feedforward_closedloop_learning/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Automatic MOC and UIC for target linefollower"
	cd /home/kinsley/github_project/feedforward_closedloop_learning/linefollower && /usr/bin/cmake -E cmake_autogen /home/kinsley/github_project/feedforward_closedloop_learning/linefollower/CMakeFiles/linefollower_autogen.dir/AutogenInfo.json RelWithDebInfo
	cd /home/kinsley/github_project/feedforward_closedloop_learning/linefollower && /usr/bin/cmake -E touch /home/kinsley/github_project/feedforward_closedloop_learning/linefollower/linefollower_autogen/timestamp

linefollower/CMakeFiles/linefollower.dir/linefollower_autogen/mocs_compilation.cpp.o: linefollower/CMakeFiles/linefollower.dir/flags.make
linefollower/CMakeFiles/linefollower.dir/linefollower_autogen/mocs_compilation.cpp.o: linefollower/linefollower_autogen/mocs_compilation.cpp
linefollower/CMakeFiles/linefollower.dir/linefollower_autogen/mocs_compilation.cpp.o: linefollower/CMakeFiles/linefollower.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=/home/kinsley/github_project/feedforward_closedloop_learning/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building CXX object linefollower/CMakeFiles/linefollower.dir/linefollower_autogen/mocs_compilation.cpp.o"
	cd /home/kinsley/github_project/feedforward_closedloop_learning/linefollower && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT linefollower/CMakeFiles/linefollower.dir/linefollower_autogen/mocs_compilation.cpp.o -MF CMakeFiles/linefollower.dir/linefollower_autogen/mocs_compilation.cpp.o.d -o CMakeFiles/linefollower.dir/linefollower_autogen/mocs_compilation.cpp.o -c /home/kinsley/github_project/feedforward_closedloop_learning/linefollower/linefollower_autogen/mocs_compilation.cpp

linefollower/CMakeFiles/linefollower.dir/linefollower_autogen/mocs_compilation.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing CXX source to CMakeFiles/linefollower.dir/linefollower_autogen/mocs_compilation.cpp.i"
	cd /home/kinsley/github_project/feedforward_closedloop_learning/linefollower && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/kinsley/github_project/feedforward_closedloop_learning/linefollower/linefollower_autogen/mocs_compilation.cpp > CMakeFiles/linefollower.dir/linefollower_autogen/mocs_compilation.cpp.i

linefollower/CMakeFiles/linefollower.dir/linefollower_autogen/mocs_compilation.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling CXX source to assembly CMakeFiles/linefollower.dir/linefollower_autogen/mocs_compilation.cpp.s"
	cd /home/kinsley/github_project/feedforward_closedloop_learning/linefollower && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/kinsley/github_project/feedforward_closedloop_learning/linefollower/linefollower_autogen/mocs_compilation.cpp -o CMakeFiles/linefollower.dir/linefollower_autogen/mocs_compilation.cpp.s

linefollower/CMakeFiles/linefollower.dir/Linefollower.cpp.o: linefollower/CMakeFiles/linefollower.dir/flags.make
linefollower/CMakeFiles/linefollower.dir/Linefollower.cpp.o: linefollower/Linefollower.cpp
linefollower/CMakeFiles/linefollower.dir/Linefollower.cpp.o: linefollower/CMakeFiles/linefollower.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=/home/kinsley/github_project/feedforward_closedloop_learning/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building CXX object linefollower/CMakeFiles/linefollower.dir/Linefollower.cpp.o"
	cd /home/kinsley/github_project/feedforward_closedloop_learning/linefollower && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT linefollower/CMakeFiles/linefollower.dir/Linefollower.cpp.o -MF CMakeFiles/linefollower.dir/Linefollower.cpp.o.d -o CMakeFiles/linefollower.dir/Linefollower.cpp.o -c /home/kinsley/github_project/feedforward_closedloop_learning/linefollower/Linefollower.cpp

linefollower/CMakeFiles/linefollower.dir/Linefollower.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing CXX source to CMakeFiles/linefollower.dir/Linefollower.cpp.i"
	cd /home/kinsley/github_project/feedforward_closedloop_learning/linefollower && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/kinsley/github_project/feedforward_closedloop_learning/linefollower/Linefollower.cpp > CMakeFiles/linefollower.dir/Linefollower.cpp.i

linefollower/CMakeFiles/linefollower.dir/Linefollower.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling CXX source to assembly CMakeFiles/linefollower.dir/Linefollower.cpp.s"
	cd /home/kinsley/github_project/feedforward_closedloop_learning/linefollower && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/kinsley/github_project/feedforward_closedloop_learning/linefollower/Linefollower.cpp -o CMakeFiles/linefollower.dir/Linefollower.cpp.s

linefollower/CMakeFiles/linefollower.dir/Racer.cpp.o: linefollower/CMakeFiles/linefollower.dir/flags.make
linefollower/CMakeFiles/linefollower.dir/Racer.cpp.o: linefollower/Racer.cpp
linefollower/CMakeFiles/linefollower.dir/Racer.cpp.o: linefollower/CMakeFiles/linefollower.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=/home/kinsley/github_project/feedforward_closedloop_learning/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Building CXX object linefollower/CMakeFiles/linefollower.dir/Racer.cpp.o"
	cd /home/kinsley/github_project/feedforward_closedloop_learning/linefollower && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT linefollower/CMakeFiles/linefollower.dir/Racer.cpp.o -MF CMakeFiles/linefollower.dir/Racer.cpp.o.d -o CMakeFiles/linefollower.dir/Racer.cpp.o -c /home/kinsley/github_project/feedforward_closedloop_learning/linefollower/Racer.cpp

linefollower/CMakeFiles/linefollower.dir/Racer.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing CXX source to CMakeFiles/linefollower.dir/Racer.cpp.i"
	cd /home/kinsley/github_project/feedforward_closedloop_learning/linefollower && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/kinsley/github_project/feedforward_closedloop_learning/linefollower/Racer.cpp > CMakeFiles/linefollower.dir/Racer.cpp.i

linefollower/CMakeFiles/linefollower.dir/Racer.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling CXX source to assembly CMakeFiles/linefollower.dir/Racer.cpp.s"
	cd /home/kinsley/github_project/feedforward_closedloop_learning/linefollower && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/kinsley/github_project/feedforward_closedloop_learning/linefollower/Racer.cpp -o CMakeFiles/linefollower.dir/Racer.cpp.s

# Object files for target linefollower
linefollower_OBJECTS = \
"CMakeFiles/linefollower.dir/linefollower_autogen/mocs_compilation.cpp.o" \
"CMakeFiles/linefollower.dir/Linefollower.cpp.o" \
"CMakeFiles/linefollower.dir/Racer.cpp.o"

# External object files for target linefollower
linefollower_EXTERNAL_OBJECTS =

linefollower/linefollower: linefollower/CMakeFiles/linefollower.dir/linefollower_autogen/mocs_compilation.cpp.o
linefollower/linefollower: linefollower/CMakeFiles/linefollower.dir/Linefollower.cpp.o
linefollower/linefollower: linefollower/CMakeFiles/linefollower.dir/Racer.cpp.o
linefollower/linefollower: linefollower/CMakeFiles/linefollower.dir/build.make
linefollower/linefollower: /usr/lib64/libOpenGL.so
linefollower/linefollower: /usr/lib64/libGLX.so
linefollower/linefollower: /usr/lib64/libQt5OpenGL.so.5.15.13
linefollower/linefollower: /usr/lib64/libQt5Widgets.so.5.15.13
linefollower/linefollower: libfcl.so.2.2.0
linefollower/linefollower: /usr/lib64/libQt5Gui.so.5.15.13
linefollower/linefollower: /usr/lib64/libQt5Core.so.5.15.13
linefollower/linefollower: linefollower/CMakeFiles/linefollower.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --bold --progress-dir=/home/kinsley/github_project/feedforward_closedloop_learning/CMakeFiles --progress-num=$(CMAKE_PROGRESS_5) "Linking CXX executable linefollower"
	cd /home/kinsley/github_project/feedforward_closedloop_learning/linefollower && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/linefollower.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
linefollower/CMakeFiles/linefollower.dir/build: linefollower/linefollower
.PHONY : linefollower/CMakeFiles/linefollower.dir/build

linefollower/CMakeFiles/linefollower.dir/clean:
	cd /home/kinsley/github_project/feedforward_closedloop_learning/linefollower && $(CMAKE_COMMAND) -P CMakeFiles/linefollower.dir/cmake_clean.cmake
.PHONY : linefollower/CMakeFiles/linefollower.dir/clean

linefollower/CMakeFiles/linefollower.dir/depend: linefollower/linefollower_autogen/timestamp
	cd /home/kinsley/github_project/feedforward_closedloop_learning && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/kinsley/github_project/feedforward_closedloop_learning /home/kinsley/github_project/feedforward_closedloop_learning/linefollower /home/kinsley/github_project/feedforward_closedloop_learning /home/kinsley/github_project/feedforward_closedloop_learning/linefollower /home/kinsley/github_project/feedforward_closedloop_learning/linefollower/CMakeFiles/linefollower.dir/DependInfo.cmake "--color=$(COLOR)"
.PHONY : linefollower/CMakeFiles/linefollower.dir/depend

