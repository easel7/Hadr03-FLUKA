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
  find_library(GCC_CXX_RUNTIME NAMES stdc++
    HINTS "$ENV{FLUKA_PATH}/lib" /opt/homebrew/opt/gcc/lib/gcc/current
    REQUIRED)
  target_link_libraries(Hadr03 PRIVATE
    ${FLUKAInterface_LIBRARIES} ${GCC_CXX_RUNTIME} ${Geant4_LIBRARIES})
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

