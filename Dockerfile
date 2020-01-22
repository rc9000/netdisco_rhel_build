
ARG CENTOS=7.6.1810
FROM centos:$CENTOS

ARG CPANM="curl -L https://cpanmin.us/"
ARG DEST=/opt/netdisco
ARG CUSTOMPATCHES=0

ENV DEST_ENV $DEST


RUN yum -y install perl-core perl-DBD-Pg net-snmp-perl net-snmp-devel openssl-devel openssl curl patch make automake gcc \
             postgresql postgresql-devel postgresql-client postgresql-server postgresql-contrib perl-Net-OpenSSH perl-Expect

RUN $CPANM | perl - --notest --local-lib $DEST/nd2 Net::SSLeay
RUN $CPANM | perl - --notest --local-lib $DEST/nd2 Sys::RunAlone
RUN $CPANM | perl - --notest --local-lib $DEST/nd2 DBD::Pg
RUN $CPANM | perl - --notest --local-lib $DEST/nd2 YAML
RUN $CPANM | perl - --notest --local-lib $DEST/nd2 Time::Local
RUN $CPANM | perl - --notest --local-lib $DEST/nd2 Time::Zone
RUN $CPANM | perl - --notest --local-lib $DEST/nd2 File::Slurp 
RUN $CPANM | perl - --notest --local-lib $DEST/nd2 REST::Client
RUN $CPANM | perl - --notest --local-lib $DEST/nd2 JSON
RUN $CPANM | perl - --notest --local-lib $DEST/nd2 LWP::Protocol::https
RUN $CPANM | perl - --notest --local-lib $DEST/nd2 URL::Encode
RUN $CPANM | perl - --notest --local-lib $DEST/nd2 Regexp::Common
RUN $CPANM | perl - --notest --local-lib $DEST/nd2 App::Netdisco

RUN curl -L https://github.com/netdisco/netdisco-mibs/releases/latest/download/netdisco-mibs.tar.gz     -o $DEST/netdisco-mibs.tar.gz
RUN curl -L https://raw.githubusercontent.com/netdisco/upstream-sources/master/ieee/oui.txt             -o $DEST/oui.txt

COPY patches/* $DEST/patches/
RUN cd $DEST/patches/ ; . ./apply.sh

CMD cd $DEST_ENV ; \
    tar cvfz /output/netdisco_rhel_build_$(grep 'our $VERSION' nd2/lib/perl5/App/Netdisco.pm | perl -pe 's/[^\d.]//g').tar.gz \
    nd2 \
    netdisco-mibs.tar.gz \
    oui.txt 
