
 MARS Install Scripts
======================

 ### 06.02.2015

This repository contains scripts that will install [MARS](http://github.com/rock-simulation/mars) and its dependencies for you with only minimal configuration effort on your part.

All you have to to is to create a clean folder that will become your MARS development folder and then clone this repository into it:

    $ mkdir mymarsdev
    $ git clone https://github.com/rock-simulation/mars_install_scripts.git

You can choose any name you like, but we will here refer to it as **mars_dev_root**. Everything that is compiled by these scripts will be cloned and installed into that folder only. Thus you can also use the MARS Install Scripts to create multiple independent MARS folders, which can be useful e.g. for testing.

> Note: If you don't have **git** installed, the install scripts can install it for you. In this case, you obviously need to download the repository manually as a zip-file and unpack it into "**mars_dev_root**/mars_install_scripts".


Detailed installation instructions
-----------------------------------

### Ubuntu

1.) Open a shell and *cd* to the *mars_install_scripts* folder in your **mars_dev_root**:

    $ cd mymarsdev/mars_install_scripts

2.) Take care of cmake, git, QT, OpenSceneGraph, libz, and opencv by entering:

    $ sh apt_get_dep.sh

3.) Finally, bootstrap and install MARS' components:

    $ bash mars.sh bootstrap packageList.txt.example

The script will ask you for your dev folder (so your version of **mars_dev_root**), the number of cpu cores that should be used in the build process and whether you would like to build in *debug* or *release* mode. You can change these options later by editing the created *config.txt* file.

> Note: The file *packageList.txt.example* is provided as an use-out-of-the-box template. It essentially lists the packages which should be installed (defined, if necessary, in packages.yml). Depending on what you want to use MARS for, this template can be modified to serve your needs.


### Mac OS X

1.) Using [macports](http://www.macports.org) is a nice way for most of the dependencies needed. First, open a shell and *cd* to the *mars_install_scripts* folder in your **mars_dev_root**:


    $ cd mymarsdev/mars_install_scripts

2.) Get cmake, git, OpenSceneGraph, libz, and opencv by entering:


    $ sh port_get_dep.sh

3.) Next, you need to install [Qt](http://qt-project.org), which is required among other things for MARS's gui. You can either install QT from the website (dmg) or you can use mac-ports.

[OpenSceneGraph](http://www.openscenegraph.org) has to be compiled from source. Unfortunately, OSG itself does not provide a wealth of documentation on how to do this. We will try and add a short HowTo here soon.

4.) Finally, you can clone and and install MARS itself:

    $ bash mars.sh bootstrap packageList.txt.example

The script will ask you for your dev folder (so your version of **mars_dev_root**), the number of cpu cores that should be used in the build process and whether you would like to build in *debug* or *release* mode. You can change these options later by editing the created *config.txt* file.

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
