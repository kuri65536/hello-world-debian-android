ANDROIDSDK=/usr/lib/android-sdk/build-tools/debian
PLATFORM=/usr/lib/android-sdk/platforms/android-23/android.jar
MINSDK=19
APP=src/coffee/source/helloworld

CLASSES:=$(wildcard $(APP)/*.kt)
CLASSES:=$(patsubst %.kt,%.class,$(CLASSES))
CLASSES:=$(patsubst src/%,obj/%,$(CLASSES))
obj:=$(word 1,$(CLASSES))

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
	$(ANDROIDSDK)/dx --dex --verbose --min-sdk-version=$(MINSDK) --output=$@ \
	    obj

$(obj): $(APP)/*.kt $(APP)/R.java
	echo $@
	kotlinc -no-jdk -classpath src:$(PLATFORM) -d obj -jvm-target 1.8 $^
	javac -bootclasspath $(PLATFORM) -classpath src -source 1.8 -target 1.8 \
	      $(filter %.java,$^)

$(APP)/R.java: AndroidManifest.xml res/*
	aapt package -f -m -J src -S res -M AndroidManifest.xml -I $(PLATFORM)

clean:
	rm -vf	$(APP)/R.java \
		obj/$(APP)/*.class \
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
