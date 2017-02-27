 #!/bin/sh  

if [ ! -d "/build" ]; then
  rm -rf ./build
fi

mkdir build
mkdir build/mac
mkdir build/iphonesimulator
mkdir build/iphoneos
mkdir build/android

cd build
# complie mac platfrom
mkdir temp
cd temp
cmake -GXcode ../../.
xcodebuild -project log_project.xcodeproj -alltargets -sdk macosx10.12 -configuration Release
mv ./Release/liblog.a ../mac/liblog.a
cd ..
rm -rf temp

# complie iOS simulator
mkdir temp
cd temp
cmake -DCMAKE_TOOLCHAIN_FILE=./iOS.toolchain.cmake  -DCMAKE_IOS_DEVELOPER_ROOT=/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/ -GXcode ../../.
xcodebuild -project log_project.xcodeproj -alltargets -sdk iphonesimulator10.2 -arch i386 -arch x86_64 -configuration Release
mv ./Release-iphonesimulator/liblog.a ../iphonesimulator/liblog.a
cd ..
rm -rf temp

# complie iOS iphone
mkdir temp
cd temp
cmake -DCMAKE_TOOLCHAIN_FILE=./iOS.toolchain.cmake  -DCMAKE_IOS_DEVELOPER_ROOT=/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/ -GXcode ../../.
xcodebuild -project log_project.xcodeproj -alltargets -sdk iphoneos10.2 -configuration Release
mv ./Release-iphoneos/liblog.a ../iphoneos/liblog.a
cd ..
rm -rf temp

# complie Android
mkdir temp
cd temp
cmake -DCMAKE_TOOLCHAIN_FILE=./android.toolchain.cmake -DANDROID_NDK=~/Develop/android-ndk-r13b/ -DCMAKE_BUILD_TYPE=Release -DANDROID_ABI="armeabi-v7a" -DANDROID_NATIVE_API_LEVEL=android-25 ../../.
make
mv ./liblog.a ../android/liblog.a
cd ..
rm -rf temp