location=`pwd`
echo $location
sed "s|change_path|$location|g" automate_dNdS_temp.bf > automate_dNdS.bf

HYPHYMP automate_dNdS.bf > run.log 
rm messages.log

grep "Log Likelihood =" run.log > dNdS.txt
grep "R=" run.log >> dNdS.txt
grep "treeScaler=" run.log >> dNdS.txt

rm run.log
