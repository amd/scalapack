#Remove the previous log files
rm -f ScalaPack_TestResults.txt
rm -f ScalaPack_Build_log.txt
echo " Building Scalapack "
echo " "

make clean  >> ScalaPack_Build_log.txt

make  >> ScalaPack_Build_log.txt

if [ -e libscalapack.a ]
	then
		echo "Scalapack build successful"
	else
		echo "Scalapack build not successful"
		exit
fi

echo " "
echo " Scalapack Testing Started "

cd TESTING
echo "SCALAPACK Test suite:"  >>../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt

echo " xcbrd "  >>../ScalaPack_TestResults.txt

mpirun xcbrd      >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xcdblu	"	 >> ../ScalaPack_TestResults.txt	

mpirun xcdblu     >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xcdtlu	"	 >> ../ScalaPack_TestResults.txt	

mpirun xcdtlu     >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xcevc	"	 >> ../ScalaPack_TestResults.txt	

mpirun xcevc      >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xcgblu	"	 >> ../ScalaPack_TestResults.txt	

mpirun xcgblu     >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xcgsep	"	 >> ../ScalaPack_TestResults.txt	

mpirun xcgsep     >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xcheevr	"	 >> ../ScalaPack_TestResults.txt	

mpirun xcheevr    >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xchrd	"	 >> ../ScalaPack_TestResults.txt	

mpirun xchrd      >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xcinv	"	 >> ../ScalaPack_TestResults.txt	

mpirun xcinv      >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xcllt	"	 >> ../ScalaPack_TestResults.txt	

mpirun xcllt      >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xcls	"	 >> ../ScalaPack_TestResults.txt	

mpirun xcls       >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xclu	"	 >> ../ScalaPack_TestResults.txt	

mpirun xclu       >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xcnep	"	 >> ../ScalaPack_TestResults.txt	

mpirun xcnep      >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xcpbllt	"	 >> ../ScalaPack_TestResults.txt	

mpirun xcpbllt    >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xcptllt	"	 >> ../ScalaPack_TestResults.txt	

mpirun xcptllt    >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xcqr	"	 >> ../ScalaPack_TestResults.txt	

mpirun xcqr       >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xcsep	"	 >> ../ScalaPack_TestResults.txt	

mpirun xcsep      >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xctrd	"	 >> ../ScalaPack_TestResults.txt	

mpirun xctrd      >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xdbrd	"	 >> ../ScalaPack_TestResults.txt	

mpirun xdbrd      >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xddblu	"	 >> ../ScalaPack_TestResults.txt	

mpirun xddblu     >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xddtlu	"	 >> ../ScalaPack_TestResults.txt	

mpirun xddtlu     >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xdgblu	"	 >> ../ScalaPack_TestResults.txt	

mpirun xdgblu     >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xdgsep	"	 >> ../ScalaPack_TestResults.txt	

mpirun xdgsep     >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xdhrd	"	 >> ../ScalaPack_TestResults.txt	

mpirun xdhrd      >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xdhseqr	"	 >> ../ScalaPack_TestResults.txt	

mpirun xdhseqr    >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xdinv	"	 >> ../ScalaPack_TestResults.txt	

mpirun xdinv      >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xdllt	"	 >> ../ScalaPack_TestResults.txt	

mpirun xdllt      >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xdls	"	 >> ../ScalaPack_TestResults.txt	

mpirun xdls       >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xdlu	"	 >> ../ScalaPack_TestResults.txt	

mpirun xdlu       >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xdnep	"	 >> ../ScalaPack_TestResults.txt	

mpirun xdnep      >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xdpbllt	"	 >> ../ScalaPack_TestResults.txt	

mpirun xdpbllt    >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xdptllt	"	 >> ../ScalaPack_TestResults.txt	

mpirun xdptllt    >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xdqr	"	 >> ../ScalaPack_TestResults.txt	

mpirun xdqr       >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xdsep	"	 >> ../ScalaPack_TestResults.txt	

mpirun xdsep      >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xdsvd	"	 >> ../ScalaPack_TestResults.txt	

mpirun xdsvd      >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xdsyevr	"	 >> ../ScalaPack_TestResults.txt	

mpirun xdsyevr    >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xdtrd	"	 >> ../ScalaPack_TestResults.txt	

mpirun xdtrd      >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xsbrd	"	 >> ../ScalaPack_TestResults.txt	

mpirun xsbrd      >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xsdblu	"	 >> ../ScalaPack_TestResults.txt	

mpirun xsdblu     >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xsdtlu	"	 >> ../ScalaPack_TestResults.txt	

mpirun xsdtlu     >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xsgblu	"	 >> ../ScalaPack_TestResults.txt	

mpirun xsgblu     >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xsgsep	"	 >> ../ScalaPack_TestResults.txt	

mpirun xsgsep     >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xshrd	"	 >> ../ScalaPack_TestResults.txt	

mpirun xshrd      >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xshseqr	"	 >> ../ScalaPack_TestResults.txt	

mpirun xshseqr    >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xsinv	"	 >> ../ScalaPack_TestResults.txt	

mpirun xsinv      >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xsllt	"	 >> ../ScalaPack_TestResults.txt	

mpirun xsllt      >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xsls	"	 >> ../ScalaPack_TestResults.txt	

mpirun xsls       >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xslu	"	 >> ../ScalaPack_TestResults.txt	

mpirun xslu       >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xsnep	"	 >> ../ScalaPack_TestResults.txt	

mpirun xsnep      >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xspbllt	"	 >> ../ScalaPack_TestResults.txt	

mpirun xspbllt    >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xsptllt	"	 >> ../ScalaPack_TestResults.txt	

mpirun xsptllt    >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xsqr	"	 >> ../ScalaPack_TestResults.txt	

mpirun xsqr       >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xssep	"	 >> ../ScalaPack_TestResults.txt	

mpirun xssep      >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xssvd	"	 >> ../ScalaPack_TestResults.txt	

mpirun xssvd      >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xssyevr	"	 >> ../ScalaPack_TestResults.txt	

mpirun xssyevr    >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xstrd	"	 >> ../ScalaPack_TestResults.txt	

mpirun xstrd      >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xzbrd	"	 >> ../ScalaPack_TestResults.txt	

mpirun xzbrd      >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xzdblu	"	 >> ../ScalaPack_TestResults.txt	

mpirun xzdblu     >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xzdtlu	"	 >> ../ScalaPack_TestResults.txt	

mpirun xzdtlu     >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xzevc	"	 >> ../ScalaPack_TestResults.txt	

mpirun xzevc      >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xzgblu	"	 >> ../ScalaPack_TestResults.txt	

mpirun xzgblu     >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xzgsep	"	 >> ../ScalaPack_TestResults.txt	

mpirun xzgsep     >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xzheevr	"	 >> ../ScalaPack_TestResults.txt	

mpirun xzheevr    >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xzhrd	"	 >> ../ScalaPack_TestResults.txt	

mpirun xzhrd      >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xzinv	"	 >> ../ScalaPack_TestResults.txt	

mpirun xzinv      >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xzllt	"	 >> ../ScalaPack_TestResults.txt	

mpirun xzllt      >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xzls	"	 >> ../ScalaPack_TestResults.txt	

mpirun xzls       >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xzlu	"	 >> ../ScalaPack_TestResults.txt	

mpirun xzlu       >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xznep	"	 >> ../ScalaPack_TestResults.txt	

mpirun xznep      >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xzpbllt	"	 >> ../ScalaPack_TestResults.txt	

mpirun xzpbllt    >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xzptllt	"	 >> ../ScalaPack_TestResults.txt	

mpirun xzptllt    >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xzqr	"	 >> ../ScalaPack_TestResults.txt	

mpirun xzqr       >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xzsep	"	 >> ../ScalaPack_TestResults.txt	

mpirun xzsep      >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xztrd	"	 >> ../ScalaPack_TestResults.txt	

mpirun xztrd      >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt

