#!/bin/csh


###!/bin/sh
# for i in script sol off on wts unc trans enc tr pi out t in o v esp priv sym
# do begin
# set b=*.$i;
# set a;
# foreach i $b
#       if ($a != ) then
#               if ((-d $a) && (-f $a:h/$i:t)) then
#                       mv $a:h/$i:t $a:h/.$i:t._;
#                       echo $a:h/$i:t;
#               endif
#       else if ((-d $i:h) && (-f $i)) then
#               mv $i $i:h/.$i:t._;
#               echo $i;
#       else if (-f $i) then
#               mv $i .$i._;
#               echo $i;
#       endif
# end
# unset a b;
# end
# done
# 

if (! -d to-delete) then
        mkdir to-delete
endif

mv *.in *.script *.sol *.off *.on *.wts *.unc *.trans *.enc *.tr *.pi *.out *.t *.in *.o *.v *.esp *.priv *.sym *.eqn to-delete/

echo ''
echo 'Auxiliary files have been moved into the'
echo 'directory "to-delete" in the current directory'
echo ''
echo 'If you are satisified that these files can be'
echo 'deleted, type "rm -rf to-delete"'
echo ""


