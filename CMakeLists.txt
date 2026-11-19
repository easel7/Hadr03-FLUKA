#----------------------------------------------------------------------------
# Setup the project
cmake_minimum_required(VERSION 3.16...3.27)
project(Hadr03)

#----------------------------------------------------------------------------
# Find Geant4 package, activating all available UI and Vis drivers by default
# You can set WITH_GEANT4_UIVIS to OFF via the command line or ccmake/cmake-gui
# to build a batch mode only executable
#
option(WITH_GEANT4_UIVIS "Build example with Geant4 UI and Vis drivers" ON)
if(WITH_GEANT4_UIVIS)
  find_package(Geant4 REQUIRED ui_all vis_all)
else()
  find_package(Geant4 REQUIRED)
endif()

#----------------------------------------------------------------------------
# Setup Geant4 include directories and compile definitions
#
include(${Geant4_USE_FILE})

#----------------------------------------------------------------------------
# Optional FLUKA hadron inelastic physics
#
option(G4_USE_FLUKA "Use the CERN FLUKA hadron inelastic interface" ON)
if(G4_USE_FLUKA)
  message(STATUS "G4_USE_FLUKA=ON: enabling the FLUKA hadron inelastic model")
  add_compile_definitions(G4_USE_FLUKA)
  find_package(FLUKAInterface REQUIRED)
else()
  message(STATUS "G4_USE_FLUKA=OFF: using the standard Geant4 physics list")
endif()

#----------------------------------------------------------------------------
# Locate sources and headers for this project
#
include_directories(${PROJECT_SOURCE_DIR}/include 
                    ${FLUKAInterface_INCLUDE_DIR}
                    ${Geant4_INCLUDE_DIR})
file(GLOB sources ${PROJECT_SOURCE_DIR}/src/*.cc)
file(GLOB headers ${PROJECT_SOURCE_DIR}/include/*.hh)

#----------------------------------------------------------------------------
# Add the executable, and link it to the Geant4 libraries
#
add_executable(Hadr03 Hadr03.cc ${sources} ${headers})
if(G4_USE_FLUKA)
  # The FLUKA archive contains GCC-built C++ code. Keep its runtime for that
  # archive; the FLUKA-G4 bridge objects are built with clang++ to match G4.
  set(FLUKA_ROOT "$ENV{FLUKA_PATH}")
  if(NOT FLUKA_ROOT)
    message(FATAL_ERROR "FLUKA_PATH is unset; source the FLUKA environment before configuring Hadr03")
  endif()
  find_library(FLUKA_NO_RANDOM_LIBRARY NAMES fluka_no_random
    HINTS "${FLUKA_ROOT}/lib" REQUIRED)
  find_library(FLUKA_RELEASE_LIBRARY NAMES fluka
    HINTS "${FLUKA_ROOT}/lib" REQUIRED)
  find_library(FLUKA_DPMJET_LIBRARY NAMES DPMJET
    HINTS "${FLUKA_ROOT}/lib" REQUIRED)
  find_library(FLUKA_RQMD_LIBRARY NAMES rqmd
    HINTS "${FLUKA_ROOT}/lib" REQUIRED)
  file(GLOB FLUKA_ION_GENERATOR_OBJECTS "${FLUKA_ROOT}/lib/interface/*.o")
  if(NOT FLUKA_ION_GENERATOR_OBJECTS)
    message(FATAL_ERROR "FLUKA DPMJET/RQMD interface objects not found under ${FLUKA_ROOT}/lib/interface")
  endif()
  # DPMJET/RQMD are separate from libfluka_no_random. Add FLUKA's bridge
  # objects and libraries in the same order used by its lfluka -d linker;
  # the release archive supplies FLUKA's fl64* helpers used by DPMJET init.
  target_sources(Hadr03 PRIVATE ${FLUKA_ION_GENERATOR_OBJECTS})
  list(FILTER FLUKAInterface_LIBRARIES EXCLUDE REGEX "libfluka_no_random\\.a$|^-lgfortran$")
  find_library(GCC_CXX_RUNTIME NAMES stdc++
    HINTS "$ENV{FLUKA_PATH}/lib" /opt/homebrew/opt/gcc/lib/gcc/current
    REQUIRED)
  target_link_libraries(Hadr03 PRIVATE
    ${FLUKAInterface_LIBRARIES}
    ${FLUKA_RQMD_LIBRARY} ${FLUKA_DPMJET_LIBRARY} ${FLUKA_NO_RANDOM_LIBRARY}
    ${FLUKA_RELEASE_LIBRARY} gfortran ${GCC_CXX_RUNTIME} ${Geant4_LIBRARIES})
else()
  target_link_libraries(Hadr03 ${Geant4_LIBRARIES})
endif()

#----------------------------------------------------------------------------
# Copy all scripts to the build directory, i.e. the directory in which we
# build Hadr03. This is so that we can run the executable directly because it
# relies on these scripts being in the current working directory.
#
set(Hadr03_SCRIPTS
    debug.mac envHadronic.csh envHadronic.sh elastic.mac gamma.mac hadr03.in inelastic.mac ion.mac nCapture.mac neutron.mac nFission.mac fusion.mac vis.mac
  )

foreach(_script ${Hadr03_SCRIPTS})
  configure_file(
    ${PROJECT_SOURCE_DIR}/${_script}
    ${PROJECT_BINARY_DIR}/${_script}
    COPYONLY
    )
endforeach()

#----------------------------------------------------------------------------
# Install the executable to 'bin' directory under CMAKE_INSTALL_PREFIX
#
install(TARGETS Hadr03 DESTINATION bin)

