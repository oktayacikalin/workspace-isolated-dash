UUID = `jq -r .uuid < src/metadata.json`

CP = rsync -aP

deps:
	pnpm install --frozen-lockfile

tsc: deps
	pnpm exec tsc

assets:
	mkdir -pv dist/
	cp -v src/metadata.json dist/metadata.json
	cp -v LICENSE dist/COPYING

build: tsc assets

install: clean build
	mkdir -pv "$(HOME)/.local/share/gnome-shell/extensions/$(UUID)/"
	$(CP) dist/ "$(HOME)/.local/share/gnome-shell/extensions/$(UUID)/"

uninstall:
	rm -rf "$(HOME)/.local/share/gnome-shell/extensions/$(UUID)/"

clean:
	find . -type f -name '*~' -delete
	rm -rfv dist/

.PHONY: deps tsc assets build install uninstall clean
