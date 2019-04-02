FROM openjdk:8-jdk
MAINTAINER Ugva Esteban <ugva@devlabers.com>

RUN mkdir -p /opt/android-sdk-linux && mkdir -p ~/.android && touch ~/.android/repositories.cfg
WORKDIR /opt

ENV ANDROID_HOME /opt/android-sdk-linux
ENV PATH ${PATH}:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools:${PATH}:${ANDROID_HOME}/tools
ENV ANDROID_BUILD_TOOLS_VERSION "4333796"

RUN apt-get update && apt-get install -y --no-install-recommends \
    unzip \
    wget
RUN cd /opt/android-sdk-linux && \
    wget -q --output-document=sdk-tools.zip https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_BUILD_TOOLS_VERSION}.zip && \
    unzip sdk-tools.zip && \
    rm -f sdk-tools.zip && \
    echo y | sdkmanager "build-tools;28.0.2" "platforms;android-28" && \
    echo y | sdkmanager "extras;android;m2repository" "extras;google;m2repository" "extras;google;google_play_services"

