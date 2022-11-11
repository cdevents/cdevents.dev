.PHONY: serve
serve:
	echo "Local development"
	./scripts/build-static.sh
	hugo server \
	--baseURL $(URL) \
	--buildDrafts \
	--buildFuture \
	--disableFastRender \
	--ignoreCache \
	--watch

.PHONY: production-build
production-build:
	./scripts/build-static.sh
	hugo --baseURL $(URL)

.PHONY: preview-build
preview-build:
	./scripts/build-static.sh
	hugo --baseURL $(DEPLOY_PRIME_URL)
