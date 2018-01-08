# This script takes a diffblue-generated testsuite, and tries to put each test file in its right module.
# Node that the script is pretty naive and is based on matching file name prefixes, so for example SomeClassTest
# will be put to the module containing SomeClass, but also to the module containing Som
# Usage ./extract-tests.sh path/to/diffblue/testsuite

d=$PWD
DIFFBLUEDIR=$1
  echo Processing $d
  if [ -d $d ]; then
    for f in `find $d/src/main -name "*.java"`; do
      BASEDIR=`dirname $f`
      TESTDIR=`echo $BASEDIR | sed "s/src\/main/src\/test/"`
      BASEFILE=`basename $f | sed "s/.java$//"`
      for t in `find $DIFFBLUEDIR -type f -name "${BASEFILE}Test.java"`; do
        echo "- Copying $t to $TESTDIR because of ${BASEFILE}Test" 
        mkdir -p $TESTDIR
        cp $t $TESTDIR;
      done
      for t in `find $DIFFBLUEDIR -type f -name "${BASEFILE}_*.java"`; do
        echo "- Copying $t to $TESTDIR because of $BASEFILE" 
        mkdir -p $TESTDIR
        cp $t $TESTDIR;
      done
    done
  fi
  echo
