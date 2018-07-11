FROM ubuntu:16.04

LABEL maintainer="jeff@levinology.com" \
	  version.ubuntu="16.04"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
		apt-get install -y -q \
		software-properties-common \
		fonts-opensymbol \
		hyphen-fr \
		hyphen-de \
		hyphen-en-us \
		hyphen-it \
		hyphen-ru \
		fonts-dejavu \
		fonts-dejavu-core \
		fonts-dejavu-extra \
		fonts-droid-fallback \
		fonts-dustin \
		fonts-f500 \
		fonts-fanwood \
		fonts-freefont-ttf \
		fonts-liberation \
		fonts-lmodern \
		fonts-lyx \
		fonts-sil-gentium \
		fonts-texgyre \
		fonts-tlwg-purisa && \
	add-apt-repository ppa:libreoffice/libreoffice-6-0 && \
	apt-get update && \
	apt-get -y -q install libreoffice &&\
	apt-get -y -q remove libreoffice-gnome && \
	apt -y autoremove && \
	apt-get clean && \
		rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/cache/apt/archives/*.deb /var/cache/apt/*cache.bin

RUN adduser --home=/opt/libreoffice --disabled-password --gecos "" --shell=/bin/bash libreoffice

VOLUME ["/tmp"]
WORKDIR "/tmp"

CMD cat - > input_file \
    # Convert 'input_file' to pdf
    && libreoffice --invisible --headless --nologo --convert-to pdf --outdir $(pwd) input_file \
    # Send converted file to stdout
    && cat input_file.pdf
