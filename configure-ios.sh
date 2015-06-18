cd julius-4.3.1

pushd libsent
./configure --enable-words-int --disable-class-ngram --disable-mbr --without-sndfile
iconv -f EUC-JP -t UTF-8 include/sent/config.h > include/sent/config.utf8.h
sed 's/#define USE_MIC 1/\/* #undef USE_MIC *\//g' include/sent/config.utf8.h > include/sent/config.h
rm include/sent/config.utf8.h
popd

pushd libjulius
./configure --disable-plugin --host=i686-apple-darwin
iconv -f EUC-JP -t UTF-8 include/julius/config.h > include/julius/config.utf8.h
sed 's/#define STDC_HEADERS 1/\/* #undef STDC_HEADERS *\//g' include/julius/config.utf8.h > include/julius/config.h
rm include/julius/config.utf8.h
echo '#undef USE_MIC'        >> include/julius/config.h
echo '#undef HAS_ALSA'       >> include/julius/config.h
echo '#undef HAS_OSS'        >> include/julius/config.h
echo '#undef HAS_ESD'        >> include/julius/config.h
echo '#undef HAS_PULSEAUDIO' >> include/julius/config.h
echo '#undef USE_NETAUDIO'   >> include/julius/config.h
echo '#undef USE_ADINNET'    >> include/julius/config.h
echo '#undef USE_STDIN'      >> include/julius/config.h
popd
