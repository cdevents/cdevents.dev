.PHONY: serve
serve:
	echo "Local development"
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
	hugo --baseURL $(URL)

.PHONY: preview-build
preview-build:
	cd themes/docsy && git submodule update -f --init
	hugo --baseURL $(DEPLOY_PRIME_URL)
