.PHONY: serve
serve:
	echo "Local development"
	cd themes/docsy && git submodule update -f --init
	cp content/en/docs/images/* static/images/
	sed -i -e 's/\(images\/[a-zA-Z\-]*\.svg\)/\/\1/g' content/en/docs/*.md
	hugo server \
	--baseURL $(URL) \
	--buildDrafts \
	--buildFuture \
	--disableFastRender \
	--ignoreCache \
	--watch

.PHONY: production-build
production-build:
	cd themes/docsy && git submodule update -f --init
	cp content/en/docs/images/* static/images/
	sed -i -e 's/\(images\/[a-zA-Z\-]*\.svg\)/\/\1/g' content/en/docs/*.md
	hugo --baseURL $(URL)

.PHONY: preview-build
preview-build:
	cd themes/docsy && git submodule update -f --init
	cp content/en/docs/images/* static/images/
	sed -i -e 's/\(images\/[a-zA-Z\-]*\.svg\)/\/\1/g' content/en/docs/*.md
	hugo --baseURL $(DEPLOY_PRIME_URL)
