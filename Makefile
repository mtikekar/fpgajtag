VERSION=17.03.1

all:
	$(MAKE) -C src

android:
	$(MAKE) -C src android

install:
	$(MAKE) -C src install

clean:
	$(MAKE) -C src clean

spkg:
	git clean -fdx
	gbp buildpackage --git-debian-tag="v%s" --git-upstream-branch=master --git-debian-branch=ubuntu --git-upstream-tag='v%(version)s' --git-ignore-new -tc -S
	git checkout debian
	sed -i s/trusty/precise/g debian/changelog
	gbp buildpackage --git-debian-tag="v%s" --git-upstream-branch=master --git-debian-branch=ubuntu --git-upstream-tag='v%(version)s'  --git-ignore-new -tc -S
	git checkout debian
	sed -i s/trusty/xenial/g debian/changelog
	gbp buildpackage --git-debian-tag="v%s" --git-upstream-branch=master --git-debian-branch=ubuntu --git-upstream-tag='v%(version)s'  --git-ignore-new -tc -S
	git checkout debian
	git clean -fdx

upload:
	git push origin v$(VERSION)
	dput ppa:jamey-hicks/connectal ../fpgajtag_$(VERSION)-*_source.changes
