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

./xcbrd      >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xcdblu	"	 >> ../ScalaPack_TestResults.txt	

./xcdblu     >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xcdtlu	"	 >> ../ScalaPack_TestResults.txt	

./xcdtlu     >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xcevc	"	 >> ../ScalaPack_TestResults.txt	

./xcevc      >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xcgblu	"	 >> ../ScalaPack_TestResults.txt	

./xcgblu     >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xcgsep	"	 >> ../ScalaPack_TestResults.txt	

./xcgsep     >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xcheevr	"	 >> ../ScalaPack_TestResults.txt	

./xcheevr    >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xchrd	"	 >> ../ScalaPack_TestResults.txt	

./xchrd      >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xcinv	"	 >> ../ScalaPack_TestResults.txt	

./xcinv      >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xcllt	"	 >> ../ScalaPack_TestResults.txt	

./xcllt      >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xcls	"	 >> ../ScalaPack_TestResults.txt	

./xcls       >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xclu	"	 >> ../ScalaPack_TestResults.txt	

./xclu       >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xcnep	"	 >> ../ScalaPack_TestResults.txt	

./xcnep      >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xcpbllt	"	 >> ../ScalaPack_TestResults.txt	

./xcpbllt    >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xcptllt	"	 >> ../ScalaPack_TestResults.txt	

./xcptllt    >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xcqr	"	 >> ../ScalaPack_TestResults.txt	

./xcqr       >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xcsep	"	 >> ../ScalaPack_TestResults.txt	

./xcsep      >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xctrd	"	 >> ../ScalaPack_TestResults.txt	

./xctrd      >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xdbrd	"	 >> ../ScalaPack_TestResults.txt	

./xdbrd      >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xddblu	"	 >> ../ScalaPack_TestResults.txt	

./xddblu     >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xddtlu	"	 >> ../ScalaPack_TestResults.txt	

./xddtlu     >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xdgblu	"	 >> ../ScalaPack_TestResults.txt	

./xdgblu     >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xdgsep	"	 >> ../ScalaPack_TestResults.txt	

./xdgsep     >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xdhrd	"	 >> ../ScalaPack_TestResults.txt	

./xdhrd      >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xdhseqr	"	 >> ../ScalaPack_TestResults.txt	

./xdhseqr    >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xdinv	"	 >> ../ScalaPack_TestResults.txt	

./xdinv      >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xdllt	"	 >> ../ScalaPack_TestResults.txt	

./xdllt      >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xdls	"	 >> ../ScalaPack_TestResults.txt	

./xdls       >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xdlu	"	 >> ../ScalaPack_TestResults.txt	

./xdlu       >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xdnep	"	 >> ../ScalaPack_TestResults.txt	

./xdnep      >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xdpbllt	"	 >> ../ScalaPack_TestResults.txt	

./xdpbllt    >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xdptllt	"	 >> ../ScalaPack_TestResults.txt	

./xdptllt    >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xdqr	"	 >> ../ScalaPack_TestResults.txt	

./xdqr       >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xdsep	"	 >> ../ScalaPack_TestResults.txt	

./xdsep      >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xdsvd	"	 >> ../ScalaPack_TestResults.txt	

./xdsvd      >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xdsyevr	"	 >> ../ScalaPack_TestResults.txt	

./xdsyevr    >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xdtrd	"	 >> ../ScalaPack_TestResults.txt	

./xdtrd      >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xsbrd	"	 >> ../ScalaPack_TestResults.txt	

./xsbrd      >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xsdblu	"	 >> ../ScalaPack_TestResults.txt	

./xsdblu     >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xsdtlu	"	 >> ../ScalaPack_TestResults.txt	

./xsdtlu     >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xsgblu	"	 >> ../ScalaPack_TestResults.txt	

./xsgblu     >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xsgsep	"	 >> ../ScalaPack_TestResults.txt	

./xsgsep     >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xshrd	"	 >> ../ScalaPack_TestResults.txt	

./xshrd      >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xshseqr	"	 >> ../ScalaPack_TestResults.txt	

./xshseqr    >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xsinv	"	 >> ../ScalaPack_TestResults.txt	

./xsinv      >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xsllt	"	 >> ../ScalaPack_TestResults.txt	

./xsllt      >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xsls	"	 >> ../ScalaPack_TestResults.txt	

./xsls       >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xslu	"	 >> ../ScalaPack_TestResults.txt	

./xslu       >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xsnep	"	 >> ../ScalaPack_TestResults.txt	

./xsnep      >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xspbllt	"	 >> ../ScalaPack_TestResults.txt	

./xspbllt    >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xsptllt	"	 >> ../ScalaPack_TestResults.txt	

./xsptllt    >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xsqr	"	 >> ../ScalaPack_TestResults.txt	

./xsqr       >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xssep	"	 >> ../ScalaPack_TestResults.txt	

./xssep      >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xssvd	"	 >> ../ScalaPack_TestResults.txt	

./xssvd      >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xssyevr	"	 >> ../ScalaPack_TestResults.txt	

./xssyevr    >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xstrd	"	 >> ../ScalaPack_TestResults.txt	

./xstrd      >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xzbrd	"	 >> ../ScalaPack_TestResults.txt	

./xzbrd      >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xzdblu	"	 >> ../ScalaPack_TestResults.txt	

./xzdblu     >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xzdtlu	"	 >> ../ScalaPack_TestResults.txt	

./xzdtlu     >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xzevc	"	 >> ../ScalaPack_TestResults.txt	

./xzevc      >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xzgblu	"	 >> ../ScalaPack_TestResults.txt	

./xzgblu     >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xzgsep	"	 >> ../ScalaPack_TestResults.txt	

./xzgsep     >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xzheevr	"	 >> ../ScalaPack_TestResults.txt	

./xzheevr    >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xzhrd	"	 >> ../ScalaPack_TestResults.txt	

./xzhrd      >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xzinv	"	 >> ../ScalaPack_TestResults.txt	

./xzinv      >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xzllt	"	 >> ../ScalaPack_TestResults.txt	

./xzllt      >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xzls	"	 >> ../ScalaPack_TestResults.txt	

./xzls       >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xzlu	"	 >> ../ScalaPack_TestResults.txt	

./xzlu       >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xznep	"	 >> ../ScalaPack_TestResults.txt	

./xznep      >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xzpbllt	"	 >> ../ScalaPack_TestResults.txt	

./xzpbllt    >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xzptllt	"	 >> ../ScalaPack_TestResults.txt	

./xzptllt    >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xzqr	"	 >> ../ScalaPack_TestResults.txt	

./xzqr       >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xzsep	"	 >> ../ScalaPack_TestResults.txt	

./xzsep      >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt
echo "	xztrd	"	 >> ../ScalaPack_TestResults.txt	

./xztrd      >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"   >> ../ScalaPack_TestResults.txt
echo " "   >> ../ScalaPack_TestResults.txt

