ANDROIDSDK=/usr/lib/android-sdk/build-tools/debian
PLATFORM=/usr/lib/android-sdk/platforms/android-23/android.jar
MINSDK=19
APP=src/coffee/source/helloworld

CLASSES=$(patsubst %.java,%.class,$(wildcard $(APP)/*.java))

# Resources:
# https://www.hanshq.net/command-line-android.html

helloworld.apk: helloworld.aligned.apk keystore.jks
	apksigner sign --ks keystore.jks --ks-key-alias androidkey --ks-pass pass:android --key-pass pass:android --out $@ $<

keystore.jks:
	keytool -genkeypair -keystore $@ -alias androidkey -validity 10000 -keyalg RSA -keysize 2048 -storepass android -keypass android

helloworld.aligned.apk: helloworld.unsigned.apk
	zipalign -f -p 4 $< $@

helloworld.unsigned.apk: dex/classes.dex AndroidManifest.xml
	aapt package -f -v -F $@ -I $(PLATFORM) -M AndroidManifest.xml -S res dex

dex/classes.dex: $(CLASSES)
	[ -e dex ] || mkdir dex
	$(ANDROIDSDK)/dx --dex --verbose --min-sdk-version=$(MINSDK) --output=$@ src

$(APP)/HelloWorld.class: $(APP)/*.java $(APP)/R.java
	javac -bootclasspath $(PLATFORM) -classpath src -source 1.7 -target 1.7 $^

$(APP)/R.java: AndroidManifest.xml res/*
	aapt package -f -m -J src -S res -M AndroidManifest.xml -I $(PLATFORM)

clean:
	rm -vf	$(APP)/R.java \
		$(APP)/*.class \
		*.unsigned.apk \
		*.aligned.apk \
		dex/*.dex

distclean: clean
	[ ! -d dex ] || rmdir dex
	rm -vf *.apk

squeaky-clean: distclean
	@echo 'Warning! This will remove your signing keys!'
	@echo 'You have 5 seconds to press CTRL-C'
	@sleep 5
	rm -vf *.jks
