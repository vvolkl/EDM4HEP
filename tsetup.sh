#!/bin/bash

LCGPREFIX=/cvmfs/sft.cern.ch/lcg
LCGPATH=/cvmfs/sft.cern.ch/lcg/views/LCG_96c_LS/x86_64-centos7-gcc8-opt

function add_to_path {
    # Add the passed value only to path if it's not already in there.
    if [ -z "$1" ] || [[ "$1" == "/lib" ]]; then
        return
    fi
    path_name=${1}
    eval path_value=\$$path_name
    path_prefix=${2}
    case ":$path_value:" in
      *":$path_prefix:"*) :;;        # already there
      *) path_value=${path_prefix}:${path_value};; # or prepend path
    esac
    eval export ${path_name}=${path_value}
}

# Setup LCG externals
source $LCGPATH/setup.sh

# if [[ $BASH == "" ]]; then
#   THIS_DIR=$(dirname $0)
# else
#   THIS_DIR=$(dirname ${BASH_SOURCE[0]})
# fi
THIS_DIR=/cvmfs/sw-nightlies.hsf.org/key4hep/views/latest/x86_64-centos7-gcc8-opt/

# Setup DD4hep from FCC view 
source $THIS_DIR/bin/thisdd4hep.sh

export BINARY_TAG=x86_64-centos7-gcc8-opt


# Add K4 software to the environment
# Setup PATH
add_to_path PATH $THIS_DIR/bin
add_to_path PATH $THIS_DIR/scripts

# Setup LD_LIBRARY_PATH
add_to_path LD_LIBRARY_PATH $THIS_DIR/lib

# Setup ROOT_INCLUDE_PATH
add_to_path ROOT_INCLUDE_PATH $THIS_DIR/include
add_to_path ROOT_INCLUDE_PATH $THIS_DIR/include/edm4hep

# Setup CMAKE_PREFIX_PATH (#REVIEW)
export CMAKE_PREFIX_PATH=$THIS_DIR:$CMAKE_PREFIX_PATH
export PODIO=$THIS_DIR

# Setup PYTHONPATH
export PYTHONPATH=$THIS_DIR/python:$PYTHONPATH
export PYTHONPATH=$THIS_DIR/lib/python2.7/site-packages/:$PYTHONPATH
add_to_path PYTHONPATH $THIS_DIR/lib
add_to_path DD4HEP_LIBRARY_PATH $THIS_DIR/lib

# Setup cmake from LCG contrib
# Temporal change to fix a bug at configuration time with FCCSW when
# using the cmake version provided by LCG release, which differs 
# from the one used to build the LCG stack itself 
# For the LCG_94 should be solved 
#export PATH=$LCGPREFIX/contrib/CMake/3.8.1/Linux-x86_64/bin:${PATH}

# Setup Gaudi_DIR since cmake files are not properly added to the LCG View
export Gaudi_DIR==/cvmfs/sft.cern.ch/lcg/releases/LCG_96c_LS/Gaudi/v32r2/x86_64-centos7-gcc8-opt/

