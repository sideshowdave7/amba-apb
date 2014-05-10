#!/bin/csh

if (! -d to-delete) then
	mkdir to-delete
endif

mv *.BAK* *.PDBAK* *~ *.area *.fullpaths *.fullpaths.min *.paths* *.power *.sdf *.ddc *.vsdc *.constraints *.out *.sdc *.svf *.log *.rtlopt.v* *.csd to-delete/

echo ''
echo 'Auxiliary files have been moved intto the'
echo 'directory "to-delete" in the current directory'
echo ''
echo 'If you are satisified that these files can be'
echo 'deleted, type "rm -rf to-delete"'
echo ""
