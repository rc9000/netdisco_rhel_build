#!/bin/bash

imagedesc="rc9000/netdisco_rhel_build:latest"

usage(){ 
    echo
    echo "    Usage: $0 [-d DEST] [-r CENTOS_RELEASE] [-p] [-n]" 
    echo
    echo "    Builds a x86_64 RHEL binary release of Netdisco, including all CPAN"
    echo "    dependencies, netdisco-mibs and IANA OUI data"
    echo 
    echo "    This is not meant to run Netdisco on RHEL, but merely to bundle all the"
    echo "    required files for isolated systems without Internet access"
    echo
    echo "    Provided as a courtesy to specific Netdisco users, if you wonder whether"
    echo "    you need this or not you probably don't"
    echo
    echo
    echo "     -d DESTDIR (/opt/netdisco)"
    echo "        Base directory of the install. Creates the following structure:"
    echo "          DESTDIR/nd2 - Netdisco installation with all dependencies for RHEL"
    echo "          DESTDIR/netdisco-mibs.tar.gz - MIBS"
    echo "          DESTDIR/oui.txt - IANA OUI database"
    echo 
    echo "        A successfuly build will bundle DESTDIR into a tarball in the ./output"
    echo "        directory of the host."
    echo
    echo "     -p include custom patches from the ./patches subdirectory"
    echo "        Do not use this unless instructed to do so"
    echo
    echo "     -r CentOS/RHEL release to use (7.6.1810)"
    echo "        See https://hub.docker.com/_/centos for available tags"
    echo
    echo "     -n disable docker build cache"
    echo


}

while getopts "r:d:np" o; do
    case "${o}" in
        r)
            centosarg="--build-arg CENTOS=${OPTARG}" 
            ;;
        d)
            destarg="--build-arg DEST=${OPTARG}" 
            ;;
        p)
            patcharg="--build-arg CUSTOMPATCHES=1"
            ;;
        n)
            chachearg="--no-cache"
            ;;
        *)
            usage
            exit;
            ;;
    esac
done
shift $((OPTIND-1))

CMD="docker build $centosarg $destarg $patcharg $cachearg -t $imagedesc ."
echo $CMD
$CMD

if [ $? -eq 0 ] ; then
    docker run --rm -v $PWD/output:/output -it $imagedesc
else
    echo "docker build failed, won't continue"
fi
