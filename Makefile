.PHONY: default
default: help

.PHONY: help
# No need to add a comment here as help is described in common/
help:
	@printf "$$(grep -hE '^\S+:.*##' $(MAKEFILE_LIST) common/Makefile | sort | sed -e 's/:.*##\s*/:/' -e 's/^\(.\+\):\(.*\)/\\x1b[36m\1\\x1b[m:\2/' | column -c2 -t -s :)\n"

%:
	make -f common/Makefile $*

install: operator-deploy post-install ## installs the pattern and loads the secrets
	@echo "Installed"

post-install: ## Post-install tasks - vault init and load-secrets
	@echo "Done"

common-test: ## runs helm tests in common/
	make -C common -f common/Makefile test

test:
	make -f common/Makefile CHARTS="$(wildcard charts/datacenter/*)" PATTERN_OPTS="-f values-datacenter.yaml" test
