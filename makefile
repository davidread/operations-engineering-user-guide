IMAGE := ministryofjustice/tech-docs-github-pages-publisher:v3

# Use this to run a local instance of the documentation site, while editing
.PHONY: preview check

preview:
	docker run --rm \
		-v $$(pwd)/config:/app/config \
		-v $$(pwd)/source:/app/source \
		-p 4567:4567 \
		-it $(IMAGE) /scripts/preview.sh

deploy:
	docker run --rm \
		-v $$(pwd)/config:/app/config \
		-v $$(pwd)/source:/app/source \
		-it $(IMAGE) /scripts/deploy.sh

check:
	docker run --rm \
		-v $$(pwd)/config:/app/config \
		-v $$(pwd)/source:/app/source \
		-it $(IMAGE) /scripts/check-url-links.sh


# Rule to rename .html.md.erb to .html.md
rename-md-erb:
	@find . -type f -name '*.html.md.erb' -exec sh -c 'mv "$$0" "$${0%.erb}"' {} \;

.PHONY: rename-md-erb
