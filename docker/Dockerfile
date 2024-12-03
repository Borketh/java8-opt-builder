FROM gcc:13

MAINTAINER borketh


# get build dependencies
RUN apt-get update
RUN apt-get install -yy build-essential zip x11-xserver-utils libx11-dev libxext-dev libxrender-dev libxtst-dev \
    libxt-dev libcups2-dev libasound2-dev 7zip

# fuck around with users so the output isn't owned by root later on
RUN useradd -ms /bin/bash beanuser
WORKDIR /app
VOLUME java-builds
RUN chown -R beanuser:beanuser /app
RUN chmod 755 /app
USER beanuser

# get Java 8 source
RUN git clone -b jdk8u432-ga --single-branch --depth 1 https://github.com/openjdk/jdk8u

WORKDIR jdk8u

# get Java 7 as the boot JVM
ADD --chown=beanuser:beanuser https://cdn.azul.com/zulu/bin/zulu7.56.0.11-ca-jdk7.0.352-linux_x64.tar.gz java7_352.tar
RUN tar -xvf ./java7_352.tar

# new warnings in new gcc https://bugs.gentoo.org/685426 \
RUN sed -i '/^WARNINGS_ARE_ERRORS/ s/-Werror/-Wno-error/' hotspot/make/linux/makefiles/gcc.make

COPY --chown=beanuser:beanuser build_targeted_march.sh .

RUN chmod +x ./configure build_targeted_march.sh
ENTRYPOINT ["./build_targeted_march.sh"]