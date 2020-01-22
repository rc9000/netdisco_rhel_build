
    Usage: ./run.sh [-d DEST] [-r CENTOS_RELEASE] [-p] [-n]

    Builds a x86_64 RHEL binary release of Netdisco, including all CPAN
    dependencies, netdisco-mibs and IANA OUI data

    This is not meant to run Netdisco on RHEL, but merely to bundle all the
    required files for isolated systems without Internet access

    Provided as a courtesy to specific Netdisco users, if you wonder whether
    you need this or not you probably don't


     -d DESTDIR (/opt/netdisco)
        Base directory of the install. Creates the following structure:
          DESTDIR/nd2 - Netdisco installation with all dependencies for RHEL
          DESTDIR/netdisco-mibs.tar.gz - MIBS
          DESTDIR/oui.txt - IANA OUI database

        A successfuly build will bundle DESTDIR into a tarball in the ./output
        directory of the host.

     -p include custom patches from the ./patches subdirectory
        Do not use this unless instructed to do so

     -r CentOS/RHEL release to use (7.6.1810)
        See https://hub.docker.com/_/centos for available tags

     -n disable docker build cache

