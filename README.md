 Welcome to the Intel Curated Repo of selinux
============================================

You can find the full, unaltered Readme.MD from the selinux project
below.

This repo contains the source for branches of selinux that are curated
and updated to contain all security fixes. This includes older versions that have
had security fixes backported to them.

Branches with Intel fixes (and Intel version numbers) have been created for all
supported releases. The current supported branches are:
- [3.8.1-Intel](https://github.com/joannaklimiuk/dellinger-02/tree/3.8.1-Intel) - [EOL April 16 2027](https://github.com/joannaklimiuk/dellinger-02/milestone/6)

- [3.8-Intel](https://github.com/joannaklimiuk/dellinger-02/tree/3.8-Intel) - [EOL January 29 2027](https://github.com/joannaklimiuk/dellinger-02/milestone/7)

- [3.7-Intel](https://github.com/joannaklimiuk/dellinger-02/tree/3.7-Intel) - [EOL June 26 2026](https://github.com/joannaklimiuk/dellinger-02/milestone/8)

- [3.6-Intel](https://github.com/joannaklimiuk/dellinger-02/tree/3.6-Intel) - [EOL December 13 2025](https://github.com/joannaklimiuk/dellinger-02/milestone/9)

The following flags were set for IPAS compliance:
```
compiler -D_FORTIFY_SOURCE=2 -fstack-protector-strong -fPIE -fPIC -fcf-protection=full -fstack-clash-protection
linker -Wl,-z,relro,-z,now
```

Other Intel information, including build commands, can be found on the [wiki](https://github.com/joannaklimiuk/dellinger-02/wiki).


***FAQ***

*How do I know all CVEs are fixed for supported branches?

That's a great question. We do everything with GitHub Issues. If you want to see what CVEs have been fixed for what
branches, just search on closed issues.

*How do you know you haven't broken anything with the branches where fixes have been backported?

Before commits are made to our repository, we ensure all available unit tests pass. This of course
doesn't mean something hasn't broken; just that there isn't a unit test that detects it. If you feel you are getting
an incorrect result, please file an Issue (https://github.com/joannaklimiuk/dellinger-02/issues).

*What do you do to prepare a branch for curation?

We start with the raw upstream source. Once we have that, we create a branch for our curated changes. That branch is always called "\<upstream branch or tag name\>-Intel". Once the branch is created, we make two Intel specific changes:
- Embed an Intelized version number (ex. "selinux v1.2.68-Intel")
- Change the default release build options to create a binary compliant with IPAS compiler flag expectations

After this, any relevant CVEs are backported to the branch.

*What happens when a new CVE is published for selinux?

The steps are simple:
- The curation team will determine which branches are affected by the new CVE
- GitHub Issues will be created for each affected branch
- When the branches are patched, the corresponding Issues will be closed with information about which commit
fixes the issue.

### How long will you be supporting these branches?

Each branch is supported for 2-years from its release date. The exceptions to this are:

1. The vendor is maintaining that product for longer than our two year support window. In that case we will support it for as long as the vendor supports their product.
2. There are no new branch releases. I.e if there latest release is further than 2-years old we will continue to support it until a new release is made.
3. The vendor is maintaining the branch for less than 2-years. In that case we will follow suit and only support it as long as they support it, despite it being less than 2 years.

To take any guesswork out of how long things will be kept up to date, Milestones (https://github.com/joannaklimiuk/dellinger-02/milestones) have been created for each individually supported branch if it goes EOL before the upstream selinux branch. If an internal release doesn't fall into that category, it is covered by blanket milestones corresponding to upstream support.


*The version of selinux I want support for isn't here.  Can you support it?

File a New Issue (https://github.com/joannaklimiuk/dellinger-02/issues/new/choose) and let's talk.

*Is this only source or are you also supplying binaries?

At this particular time, we are only supply source. If you want binaries, please file a New Issue (https://github.com/joannaklimiuk/dellinger-02/issues/new/choose).

*I have a question that isn't answered here.  What do I do?

Please file a New Issue: (https://github.com/joannaklimiuk/dellinger-02/issues/new/choose)!

----------------------------------------------------------------------------------------------------------


SELinux Userspace
=================

![SELinux logo](https://github.com/SELinuxProject.png)
[![Run Tests](https://github.com/SELinuxProject/selinux/actions/workflows/run_tests.yml/badge.svg)](https://github.com/SELinuxProject/selinux/actions/workflows/run_tests.yml)
[![Run SELinux testsuite in Testing Farm](https://github.com/SELinuxProject/selinux/actions/workflows/tf_testsuite.yml/badge.svg)](https://github.com/SELinuxProject/selinux/actions/workflows/tf_testsuite.yml)
[![OSS-Fuzz Status](https://oss-fuzz-build-logs.storage.googleapis.com/badges/selinux.svg)](https://oss-fuzz-build-logs.storage.googleapis.com/index.html#selinux)
[![CIFuzz Status](https://github.com/SELinuxProject/selinux/actions/workflows/cifuzz.yml/badge.svg)](https://github.com/SELinuxProject/selinux/actions/workflows/cifuzz.yml)

SELinux is a flexible Mandatory Access Control (MAC) system built into the
Linux Kernel. SELinux provides administrators with a comprehensive access
control mechanism that enables greater access granularity over the existing
Linux Discretionary Access Controls (DAC) and is present in many major Linux
distributions. This repository contains the sources for the SELinux utilities
and system libraries which allow for the configuration and management of an
SELinux-based system.

Please submit all bug reports and patches to the <selinux@vger.kernel.org>
mailing list. You can subscribe by sending "subscribe selinux" in the body of
an email to <majordomo@vger.kernel.org>. Archives of the mailing list are
available at https://lore.kernel.org/selinux.

Installation
------------

SELinux libraries and tools are packaged in several Linux distributions:

* Alpine Linux (https://pkgs.alpinelinux.org/package/edge/testing/x86/policycoreutils)
* Arch Linux User Repository (https://aur.archlinux.org/packages/policycoreutils/)
* Buildroot (https://git.buildroot.net/buildroot/tree/package/policycoreutils)
* Debian and Ubuntu (https://packages.debian.org/sid/policycoreutils)
* Gentoo (https://packages.gentoo.org/packages/sys-apps/policycoreutils)
* RHEL and Fedora (https://src.fedoraproject.org/rpms/policycoreutils)
* Yocto Project (http://git.yoctoproject.org/cgit/cgit.cgi/meta-selinux/tree/recipes-security/selinux)
* and many more (https://repology.org/project/policycoreutils/versions)


Building and testing
--------------------

Build dependencies on Fedora:

```sh
# For C libraries and programs
dnf install \
    audit-libs-devel \
    bison \
    bzip2-devel \
    CUnit-devel \
    diffutils \
    flex \
    gcc \
    gettext \
    glib2-devel \
    make \
    libcap-devel \
    libcap-ng-devel \
    pam-devel \
    pcre2-devel \
    xmlto

# For Python and Ruby bindings
dnf install \
    python3-devel \
    python3-pip \
    python3-setuptools \
    python3-wheel \
    ruby-devel \
    swig
```

Build dependencies on Debian:

```sh
# For C libraries and programs
apt-get install --no-install-recommends --no-install-suggests \
    bison \
    flex \
    gawk \
    gcc \
    gettext \
    make \
    libaudit-dev \
    libbz2-dev \
    libcap-dev \
    libcap-ng-dev \
    libcunit1-dev \
    libglib2.0-dev \
    libpcre2-dev \
    pkgconf \
    python3 \
    systemd \
    xmlto

# For Python and Ruby bindings
apt-get install --no-install-recommends --no-install-suggests \
    python3-dev \
    python3-pip \
    python3-setuptools \
    python3-wheel \
    ruby-dev \
    swig
```

To build and install everything under a private directory, run:

    make clean distclean

    make DESTDIR=~/obj install install-rubywrap install-pywrap

On Debian the environment variable `DEB_PYTHON_INSTALL_LAYOUT` needs to be set
to `deb` when installing the Python wrappers in order to create the correct
Python directory structure.
On Debian systems older than bookworm set
`PYTHON_SETUP_ARGS='--install-option "--install-layout=deb"'` instead.

To run tests with the built libraries and programs, several paths (relative to `$DESTDIR`) need to be added to variables `$LD_LIBRARY_PATH`, `$PATH` and `$PYTHONPATH`.
This can be done using [./scripts/env_use_destdir](./scripts/env_use_destdir):

    DESTDIR=~/obj ./scripts/env_use_destdir make test

Some tests require the reference policy to be installed (for example in `python/sepolgen`).

To install as the default system libraries and binaries
(overwriting any previously installed ones - dangerous!),
on x86_64, run:

    make LIBDIR=/usr/lib64 SHLIBDIR=/lib64 install install-pywrap relabel

or on x86 (32-bit), run:

    make install install-pywrap relabel

This may render your system unusable if the upstream SELinux userspace
lacks library functions or other dependencies relied upon by your
distribution.  If it breaks, you get to keep both pieces.


## Setting CFLAGS

Setting CFLAGS during the make process will cause the omission of many defaults. While the project strives
to provide a reasonable set of default flags, custom CFLAGS could break the build, or have other undesired
changes on the build output. Thus, be very careful when setting CFLAGS. CFLAGS that are encouraged to be
set when overriding are:

- -fno-semantic-interposition for gcc or compilers that do not do this. clang does this by default. clang-10 and up
   will support passing this flag, but ignore it. Previous clang versions fail.


macOS
-----

To install libsepol on macOS (mainly for policy analysis):

    cd libsepol; make PREFIX=/usr/local install

This requires GNU coreutils:

    brew install coreutils
