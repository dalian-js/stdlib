
# VARIABLES #

# Determine the host kernel:
KERNEL ?= $(shell uname -s)

# Based on the kernel, determine the `open` command:
ifeq ($(KERNEL), Darwin)
	OPEN ?= open
else
	OPEN ?= xdg-open
endif
# TODO: add Windows command

# Define the path to the Istanbul executable:
JAVASCRIPT_TEST_COV ?= $(BIN_DIR)/istanbul cover

# Define the type of report Istanbul should produce:
ISTANBUL_REPORT ?= lcov

# Define the output file path for the HTML report generated by Istanbul:
ISTANBUL_HTML_REPORT ?= $(COVERAGE_DIR)/lcov-report/index.html

# Define the command-line options to be used when invoking the Istanbul executable:
ISTANBUL_TEST_COV_FLAGS ?= --no-default-excludes \
		-x 'node_modules/**' \
		-x 'build/**' \
		-x '**/test/**' \
		-x '**/tests/**' \
		-x 'reports/**' \
		--dir $(COVERAGE_DIR) \
		--report $(ISTANBUL_REPORT)


# TARGETS #

# Run units and generate a test coverage report.
#
# This target instruments source code using [Istanbul][1], runs unit tests, and outputs a test coverage report.
#
# To install Istanbul:
#     $ npm install istanbul
#
# [1]: https://github.com/gotwarlost/istanbul

test-istanbul: $(NODE_MODULES)
	NODE_ENV=$(NODE_ENV_TEST) \
	NODE_PATH=$(NODE_PATH_TEST) \
	$(JAVASCRIPT_TEST_COV) $(ISTANBUL_TEST_COV_FLAGS) $(JAVASCRIPT_TEST) -- $(JAVASCRIPT_TEST_FLAGS) $(TESTS)

.PHONY: test-istanbul


# View a test coverage report.
#
# This target opens an HTML coverage report in a local web browser.

view-istanbul-report:
	$(OPEN) $(ISTANBUL_HTML_REPORT)

.PHONY: view-istanbul-report
