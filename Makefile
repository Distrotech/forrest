JARFILE=build/dist/shbat/build/xml-forrest.jar
PREFIX=/opt/forrest

all: $(JARFILE)

$(JARFILE):
	cd main; \
	./build.sh dist

clean:
	cd main; \
	ant clean

install: all
	install -d $(DESTDIR)$(PREFIX)
	rsync -a build/dist/shbat/* $(DESTDIR)$(PREFIX)/

distclean: clean
