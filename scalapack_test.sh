echo " Building Scalapack "
echo " "

make clean  >> ScalaPack_Build_log.txt

make  >> ScalaPack_Build_log.txt

echo "Build completed Successfully"

echo " "
echo " Scalapack Testing Started "

cd TESTING
echo "SCALAPACK Test suite:" >>../ScalaPack_TestResults.txt

./xcbrd     >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"  >> ../ScalaPack_TestResults.txt
echo " "  >> ../ScalaPack_TestResults.txt

./xcdblu    >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"  >> ../ScalaPack_TestResults.txt
echo " "  >> ../ScalaPack_TestResults.txt

./xcdtlu    >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"  >> ../ScalaPack_TestResults.txt
echo " "  >> ../ScalaPack_TestResults.txt

./xcevc     >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"  >> ../ScalaPack_TestResults.txt
echo " "  >> ../ScalaPack_TestResults.txt

./xcgblu    >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"  >> ../ScalaPack_TestResults.txt
echo " "  >> ../ScalaPack_TestResults.txt

./xcgsep    >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"  >> ../ScalaPack_TestResults.txt
echo " "  >> ../ScalaPack_TestResults.txt

./xcheevr   >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"  >> ../ScalaPack_TestResults.txt
echo " "  >> ../ScalaPack_TestResults.txt

./xchrd     >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"  >> ../ScalaPack_TestResults.txt
echo " "  >> ../ScalaPack_TestResults.txt

./xcinv     >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"  >> ../ScalaPack_TestResults.txt
echo " "  >> ../ScalaPack_TestResults.txt

./xcllt     >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"  >> ../ScalaPack_TestResults.txt
echo " "  >> ../ScalaPack_TestResults.txt

./xcls      >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"  >> ../ScalaPack_TestResults.txt
echo " "  >> ../ScalaPack_TestResults.txt

./xclu      >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"  >> ../ScalaPack_TestResults.txt
echo " "  >> ../ScalaPack_TestResults.txt

./xcnep     >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"  >> ../ScalaPack_TestResults.txt
echo " "  >> ../ScalaPack_TestResults.txt

./xcpbllt   >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"  >> ../ScalaPack_TestResults.txt
echo " "  >> ../ScalaPack_TestResults.txt

./xcptllt   >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"  >> ../ScalaPack_TestResults.txt
echo " "  >> ../ScalaPack_TestResults.txt

./xcqr      >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"  >> ../ScalaPack_TestResults.txt
echo " "  >> ../ScalaPack_TestResults.txt

./xcsep     >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"  >> ../ScalaPack_TestResults.txt
echo " "  >> ../ScalaPack_TestResults.txt

./xctrd     >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"  >> ../ScalaPack_TestResults.txt
echo " "  >> ../ScalaPack_TestResults.txt

./xdbrd     >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"  >> ../ScalaPack_TestResults.txt
echo " "  >> ../ScalaPack_TestResults.txt

./xddblu    >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"  >> ../ScalaPack_TestResults.txt
echo " "  >> ../ScalaPack_TestResults.txt

./xddtlu    >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"  >> ../ScalaPack_TestResults.txt
echo " "  >> ../ScalaPack_TestResults.txt

./xdgblu    >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"  >> ../ScalaPack_TestResults.txt
echo " "  >> ../ScalaPack_TestResults.txt

./xdgsep    >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"  >> ../ScalaPack_TestResults.txt
echo " "  >> ../ScalaPack_TestResults.txt

./xdhrd     >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"  >> ../ScalaPack_TestResults.txt
echo " "  >> ../ScalaPack_TestResults.txt

./xdhseqr   >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"  >> ../ScalaPack_TestResults.txt
echo " "  >> ../ScalaPack_TestResults.txt

./xdinv     >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"  >> ../ScalaPack_TestResults.txt
echo " "  >> ../ScalaPack_TestResults.txt

./xdllt     >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"  >> ../ScalaPack_TestResults.txt
echo " "  >> ../ScalaPack_TestResults.txt

./xdls      >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"  >> ../ScalaPack_TestResults.txt
echo " "  >> ../ScalaPack_TestResults.txt

./xdlu      >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"  >> ../ScalaPack_TestResults.txt
echo " "  >> ../ScalaPack_TestResults.txt

./xdnep     >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"  >> ../ScalaPack_TestResults.txt
echo " "  >> ../ScalaPack_TestResults.txt

./xdpbllt   >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"  >> ../ScalaPack_TestResults.txt
echo " "  >> ../ScalaPack_TestResults.txt

./xdptllt   >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"  >> ../ScalaPack_TestResults.txt
echo " "  >> ../ScalaPack_TestResults.txt

./xdqr      >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"  >> ../ScalaPack_TestResults.txt
echo " "  >> ../ScalaPack_TestResults.txt

./xdsep     >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"  >> ../ScalaPack_TestResults.txt
echo " "  >> ../ScalaPack_TestResults.txt

./xdsvd     >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"  >> ../ScalaPack_TestResults.txt
echo " "  >> ../ScalaPack_TestResults.txt

./xdsyevr   >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"  >> ../ScalaPack_TestResults.txt
echo " "  >> ../ScalaPack_TestResults.txt

./xdtrd     >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"  >> ../ScalaPack_TestResults.txt
echo " "  >> ../ScalaPack_TestResults.txt

./xsbrd     >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"  >> ../ScalaPack_TestResults.txt
echo " "  >> ../ScalaPack_TestResults.txt

./xsdblu    >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"  >> ../ScalaPack_TestResults.txt
echo " "  >> ../ScalaPack_TestResults.txt

./xsdtlu    >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"  >> ../ScalaPack_TestResults.txt
echo " "  >> ../ScalaPack_TestResults.txt

./xsgblu    >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"  >> ../ScalaPack_TestResults.txt
echo " "  >> ../ScalaPack_TestResults.txt

./xsgsep    >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"  >> ../ScalaPack_TestResults.txt
echo " "  >> ../ScalaPack_TestResults.txt

./xshrd     >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"  >> ../ScalaPack_TestResults.txt
echo " "  >> ../ScalaPack_TestResults.txt

./xshseqr   >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"  >> ../ScalaPack_TestResults.txt
echo " "  >> ../ScalaPack_TestResults.txt

./xsinv     >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"  >> ../ScalaPack_TestResults.txt
echo " "  >> ../ScalaPack_TestResults.txt

./xsllt     >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"  >> ../ScalaPack_TestResults.txt
echo " "  >> ../ScalaPack_TestResults.txt

./xsls      >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"  >> ../ScalaPack_TestResults.txt
echo " "  >> ../ScalaPack_TestResults.txt

./xslu      >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"  >> ../ScalaPack_TestResults.txt
echo " "  >> ../ScalaPack_TestResults.txt

./xsnep     >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"  >> ../ScalaPack_TestResults.txt
echo " "  >> ../ScalaPack_TestResults.txt

./xspbllt   >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"  >> ../ScalaPack_TestResults.txt
echo " "  >> ../ScalaPack_TestResults.txt

./xsptllt   >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"  >> ../ScalaPack_TestResults.txt
echo " "  >> ../ScalaPack_TestResults.txt

./xsqr      >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"  >> ../ScalaPack_TestResults.txt
echo " "  >> ../ScalaPack_TestResults.txt

./xssep     >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"  >> ../ScalaPack_TestResults.txt
echo " "  >> ../ScalaPack_TestResults.txt

./xssvd     >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"  >> ../ScalaPack_TestResults.txt
echo " "  >> ../ScalaPack_TestResults.txt

./xssyevr   >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"  >> ../ScalaPack_TestResults.txt
echo " "  >> ../ScalaPack_TestResults.txt

./xstrd     >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"  >> ../ScalaPack_TestResults.txt
echo " "  >> ../ScalaPack_TestResults.txt

./xzbrd     >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"  >> ../ScalaPack_TestResults.txt
echo " "  >> ../ScalaPack_TestResults.txt

./xzdblu    >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"  >> ../ScalaPack_TestResults.txt
echo " "  >> ../ScalaPack_TestResults.txt

./xzdtlu    >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"  >> ../ScalaPack_TestResults.txt
echo " "  >> ../ScalaPack_TestResults.txt

./xzevc     >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"  >> ../ScalaPack_TestResults.txt
echo " "  >> ../ScalaPack_TestResults.txt

./xzgblu    >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"  >> ../ScalaPack_TestResults.txt
echo " "  >> ../ScalaPack_TestResults.txt

./xzgsep    >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"  >> ../ScalaPack_TestResults.txt
echo " "  >> ../ScalaPack_TestResults.txt

./xzheevr   >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"  >> ../ScalaPack_TestResults.txt
echo " "  >> ../ScalaPack_TestResults.txt

./xzhrd     >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"  >> ../ScalaPack_TestResults.txt
echo " "  >> ../ScalaPack_TestResults.txt

./xzinv     >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"  >> ../ScalaPack_TestResults.txt
echo " "  >> ../ScalaPack_TestResults.txt

./xzllt     >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"  >> ../ScalaPack_TestResults.txt
echo " "  >> ../ScalaPack_TestResults.txt

./xzls      >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"  >> ../ScalaPack_TestResults.txt
echo " "  >> ../ScalaPack_TestResults.txt

./xzlu      >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"  >> ../ScalaPack_TestResults.txt
echo " "  >> ../ScalaPack_TestResults.txt

./xznep     >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"  >> ../ScalaPack_TestResults.txt
echo " "  >> ../ScalaPack_TestResults.txt

./xzpbllt   >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"  >> ../ScalaPack_TestResults.txt
echo " "  >> ../ScalaPack_TestResults.txt

./xzptllt   >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"  >> ../ScalaPack_TestResults.txt
echo " "  >> ../ScalaPack_TestResults.txt

./xzqr      >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"  >> ../ScalaPack_TestResults.txt
echo " "  >> ../ScalaPack_TestResults.txt

./xzsep     >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"  >> ../ScalaPack_TestResults.txt
echo " "  >> ../ScalaPack_TestResults.txt

./xztrd     >> ../ScalaPack_TestResults.txt
sleep 3
echo "---------------------------------------------------------"  >> ../ScalaPack_TestResults.txt
echo " "  >> ../ScalaPack_TestResults.txt

