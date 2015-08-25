 MARS Install Scripts
======================

 ### (25.08.2015)

This repository contains scripts that will install
[MARS](http://github.com/rock-simulation/mars) and its dependencies for you
with only minimal configuration effort on your part.

All you have to do is to create a clean folder that will become your main
development folder and then clone this repository into it:

    $ mkdir dev_root
    $ git clone https://github.com/rock-simulation/mars_install_scripts.git

You can choose any name you like, but we will here refer to it as **dev_root**.
Everything that is compiled by these scripts will be cloned and installed into
that folder only. Thus you can also use the install scripts to create
multiple independent `dev` folders, which can be useful e.g. for testing.

> Note: If you don't have **git** installed, the install scripts can install
it for you. In this case, you obviously need to download the repository
manually as a zip-file and unpack it into "**dev_root**/mars_install_scripts".


Generally, to install MARS you can use:

    $ bash mars.sh bootstrap packageList.txt.example

> Note: You have to install the system dependencies on your own! See the
detailed description for your operating system below.


If you want to setup the environment to use the install scripts for other
projects than MARS just use:

    $ bash mars.sh envsh


Detailed installation instructions
-----------------------------------


### Ubuntu

1.) Open a shell and *cd* to the *mars_install_scripts* folder in your **dev_root**:

    $ cd dev_root/mars_install_scripts

2.) Take care of cmake, git, QT, OpenSceneGraph, libz, and opencv by entering:

    $ sh apt_get_dep.sh

3.) Finally, bootstrap and install MARS' components:

    $ bash mars.sh bootstrap packageList.txt.example

> Note: The file *packageList.txt.example* is provided as an use-out-of-the-box
template. It essentially lists the packages which should be installed (defined,
if necessary, in packages.yml). Depending on what you want to use MARS for,
this template can be modified to serve your needs.


### Mac OS X (10.9.5)

1.) Using [macports](http://www.macports.org) is a nice way for most of the dependencies needed. First, open a shell and *cd* to the *mars_install_scripts* folder in your **mars_dev_root**:

    $ cd dev_root/mars_install_scripts

2.) Get wget, cmake, boost, pkgconfig, tinyxml, Qt5, and OpenCV by entering:

    $ sh port_get_dep.sh

3.) Next, [OpenSceneGraph](http://www.openscenegraph.org) has to be compiled from source. Following you'll find a short HowTo.

  1. Get the source code for *OpenSceneGraph* (Version 3.2.1) as a zip from the [website](http://www.openscenegraph.org/downloads/developer_releases/OpenSceneGraph-3.2.1.zip) or check it out via SVN
  ```
  $ svn co http://svn.openscenegraph.org/osg/OpenSceneGraph/tags/OpenSceneGraph-3.2.1
  ```

  2. *cd* into the *OpenSceneGraph* folder
  ```
  $ cd OpenSceneGraph-3.2.1
  ```

  3. Uncomment line 820 of `CMakeLists.txt` in order to build OpenSceneGraph using *c++11* instead of *c++98*.
  ```
  816         IF (APPLE)
  817             # set standard lib, clang defaults to c++0x
  818             set(CMAKE_XCODE_ATTRIBUTE_CLANG_CXX_LANGUAGE_STANDARD "c++98")
  819             set(CMAKE_XCODE_ATTRIBUTE_CLANG_CXX_LIBRARY "libstdc++")
  820 #            set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++98 -stdlib=libstdc++ -Wno-overloaded-virtual -Wno-conversion")
  821             set(WARNING_CFLAGS "")
  822         ENDIF()
  823 ENDIF()
  ```

  4. Create a "build" folder and *cd* into it.
  ```
  $ mkdir build
  $ cd build
  ```

  5. Call *cmake* in order to configure the upcoming build process.
  ```
  $ cmake ..
  ```
  > Note: Depending whether you want to install OpenSceneGraph *globally* (in your system) or *locally* (e.g. in *mymarsdev*) you may have to add an install prefix to your *cmake* call.
  ```
  cmake .. -DCMAKE_INSTALL_PREFIX=mymarsdev/install
  ```

  6. Build and install *OpenSceneGraph*.
  ```
  $ make install
  ```
  > Note: If you want to install *OpenSceneGraph* *globally* you have to have admin rights in order to do so.
  ```
  $ sudo make install
  ```

4.) Finally, you can clone and and install MARS itself:

    $ bash mars.sh bootstrap packageList.txt.example

> Note: The file *packageList.txt.example* is provided as an use-out-of-the-box template. It essentially lists the packages which should be installed (defined, if necessary, in packages.yml). Depending on what you want to use MARS for, this template can be modified to serve your needs.


### Windows 7

It's a bit more difficult to set up MARS on Windows systems, as you have to take a number of manual steps:

1. cmake:
    - download and install the [cmake Win32 Installer](http://www.cmake.org/cmake/resources/software.html) from cmake.org
    - add the installed bin folder to your environment **PATH**
2. git:
    - download and install git for windows
    - add the installed bin folder to your environment **PATH**
    a more detailed description will be added here soon
3. Qt:
    - install [Qt](http://qt-project.org) from qt-project.org
    - set **QTDIR** environment variable to your Qt installation: ```$ QTDIR=C:\Qt\2010.04\qt```
4. msys:
    - download and install msys: http://www.mingw.org/wiki/MSYS
5. OpenSceneGraph:
    - Download the sources from the [OSG website](http://www.openscenegraph.org) and compile it on your system.
    - If you are working at the [DFKI](http://robotik.dfki-bremen.de/), you can find a precompiled version here: *research/projects/all/MARS/development/software/Win32_install*.
You have to unzip the OpenSceneGraph-2.8.3-install.zip e.g. into C:\Developer\ and set a **OSGDIR** environment variable to point to your OpenSceneGraph installation: ```OSGDIR=C:\Developer\OpenSceneGraph-2.8.3-install```.
6. MinGW update:
    - **NOTE:** this is currently only available for DFKI employees.
    - unpack the mingw_lib_update.zip from "research/projects/all/MARS/development/software/Win32_install" into the Qt mingw folder e.g. C:\Qt\2010.04

      **WARNING**: don't remove the old folder just extend it with the zipped one
7.) Get and install MARS:
    - open an msys terminal
    - and use the install script within your dev folder: ```bash mars.sh bootstrap packageList.txt.example```
