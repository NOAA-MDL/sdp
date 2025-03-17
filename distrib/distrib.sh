#!/usr/bin/env bash
#-------------------------------------------------------------------------------
# distrib.sh                                             Last Change: 2025-03-17
#                                                         Arthur.Taylor@noaa.gov
#                                                               NWS/OSTI/MDL/DSD
#-------------------------------------------------------------------------------
base=$(basename -- "$0")
if [[ $# -ne 1 || $1 == "help" ]] ; then
   echo "Package the SLOSH Display Program by calling slosh_nsi.tcl."
   echo ""
   echo "Usage: $base <cmd>, where <cmd> is:"
   echo "   help  = Display this message and exit"
   echo "   go    = Call slosh_nsi.tcl"
   echo ""
   echo "Example:"
   echo "  $ $base go => Package the SDP"
   exit 0
fi

if [[ $1 != "go" ]] ; then $0 help; exit 0; fi

#=================================================================== START =====
#srcDir=$(cd "$(dirname "$0")" && pwd)
rootDir=$(cd "$(dirname "$0")/.." && pwd)
execDir=$rootDir/bin

echo "Please make sure $rootDir/sloshdsp.kit is up to date"
echo "also, make sure you run $rootDir/setup.tcl for the dd3.kit and shp-files"

ans=$($execDir/tclkit854 $rootDir/sloshdsp.kit -V | grep Version)
Ver=${ans:8}
ans=$($execDir/tclkit854 $rootDir/sloshdsp.kit -V | grep Date | grep -v Revision)
Date=${ans:5}

#slosh_nsi.tcl $Ver $Date >@ stdout 2>@ stderr
../bin/tclkitsh854 slosh_nsi.tcl $Ver $Date

#catch {exec /cygdrive/d/Users/Arthur.Taylor/Programs/NSIS/makensis sloshdsp.nsi} ans
#catch {exec /cygdrive/c/arthur/myPrograms/nsis/makensis sloshdsp.nsi} ans
#catch {exec /cygdrive/c/sys/Portable/PortableApps/NSISPortableANSI/app/NSIS/makensis sloshdsp.nsi} ans
#/mingw32/bin/makensis sloshdsp.nsi
#/c/sys/Portable/PortableApps/NSISPortable/App/NSIS/makensis sloshdsp.nsi
/c/arthur2/sys/Portable/PortableApps/NSISPortable/App/NSIS/makensis sloshdsp.nsi

#echo "Now 'scp sloshdsp-install.exe svn@slosh.nws.noaa.gov:/www/html/sloshPriv/download'"
#echo "Now 'scp sloshdsp-all.tar.gz svn@slosh.nws.noaa.gov:/www/html/sloshPriv/download'"
#echo "Now 'scp ../sloshdsp.vfs/version.txt svn@slosh.nws.noaa.gov:/www/html/sloshPriv/download'"
#echo "Now 'scp ../sloshdsp.kit svn@slosh.nws.noaa.gov:/www/html/sloshPriv/program'"
#echo "Now 'scp ../dd3.kit svn@slosh.nws.noaa.gov:/www/html/sloshPriv/program'"
