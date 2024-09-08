###############################################################################
# User settings
###############################################################################
VERSION			 = 1.0.0

#######################################
# Docker
#######################################
DOCKER			 = docker
BUILD_IMAGE		 = nginx
RUN_PORT		 = 8080

BUILD_FLAGS		 = --tag $(BUILD_IMAGE):$(VERSION)
BUILD_FLAGS		+= --rm

RUN_FLAGS		 = --name $(BUILD_IMAGE)
RUN_FLAGS		+= --detach
RUN_FLAGS		+= --rm
RUN_FLAGS		+= --env NGINX_HOST=localhost
RUN_FLAGS		+= --env NGINX_PORT=80
RUN_FLAGS		+= --publish $(RUN_PORT):80

###############################################################################
# Rules
###############################################################################
all: build run

.PHONY: build
build:
	$(DOCKER) build $(BUILD_FLAGS) .
	$(DOCKER) tag $(BUILD_IMAGE):$(VERSION) $(BUILD_IMAGE):latest

.PHONY: run
run:
	$(DOCKER) run $(RUN_FLAGS) $(BUILD_IMAGE):latest

.PHONY: clean
clean:
	rm -rf $(VENV) $(BUILDDIR)
	$(DOCKER) image prune --all --force
