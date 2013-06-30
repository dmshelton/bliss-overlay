# Copyright (C) 2013 Jonathan Vasquez <jvasquez1011@gmail.com>
# Distributed under the terms of the Simplified BSD License.

EAPI="4"

inherit eutils mount-boot

# Local Version
LV="FB.02"

# Other Variables
_M="/lib/modules/${PV}-${LV}"

# Main
DESCRIPTION="Precompiled ${PV}: Kernel + Modules"
HOMEPAGE="http://funtoo.org/"
SRC_URI="http://ftp.osuosl.org/pub/funtoo/distfiles/${PN}/${PV}-${LV}/kernel-${PV}-${LV}.tar.bz2"

RESTRICT="mirror binchecks strip"
LICENSE="GPL-2"
SLOT="${PV}-${LV}"
KEYWORDS="~amd64"

DEPEND="=sys-kernel/bliss-headers-${PV}-${PR}"
RDEPEND="=sys-kernel/bliss-blacklist-1-r1"

S="${WORKDIR}"

src_compile() {
	# Unset ARCH so that you don't get Makefile not found messages
	unset ARCH && return;
}

src_install()
{
	mkdir ${D}/boot/
	cp -r ${S}/kernel/* ${D}/boot/

	mkdir -p ${D}/lib/modules/
	cp -r ${S}/modules/* ${D}/lib/modules/
}

pkg_postrm()
{
	# Check to see if the modules directory was removed
	if [ -d "${_M}" ]; then
		rm -rf ${_M}
	fi
}
