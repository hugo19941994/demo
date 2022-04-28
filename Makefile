PROJECT=$(shell head -n 1 NAME | tr -d '\n')

VERSION=$(shell git describe --exact-match --tags --abbrev=0 HEAD 2>/dev/null | tr -d '\n')
ifeq ($(VERSION),)
    VERSION=latest
endif

IMAGE_NAME=654190527503.dkr.ecr.eu-west-1.amazonaws.com/smartdigits/$(PROJECT)


$(info )
$(info Making Release: $(IMAGE_NAME):$(VERSION))
$(info --------------)
$(info )

.PHONY: package
package:
	docker build --build-arg VERSION=$(VERSION) -t $(IMAGE_NAME):latest -t $(IMAGE_NAME):$(VERSION) .
	helm package chart --app-version $(VERSION)

.PHONY: publish
publish: package
	docker push $(IMAGE_NAME):latest
	docker push $(IMAGE_NAME):$(VERSION)
	helm push $(PROJECT)-*.tgz oci://654190527503.dkr.ecr.eu-west-1.amazonaws.com/smartdigits/charts/
	@echo
	@echo Published Release: $(IMAGE_NAME):$(VERSION)
	@echo -----------------
	@echo

# To test the production build using docker locally
.PHONY: run
run: package
	docker run --rm -p 3000:3000 -d --name $(PROJECT) $(IMAGE_NAME):latest
