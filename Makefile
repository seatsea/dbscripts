IMAGE:=dbscripts/test
RUN_OPTIONS:=-t --rm --network=none -v $(PWD):/dbscripts:ro --tmpfs=/tmp:exec -w /dbscripts/test

test-image:
	docker build --pull -t $(IMAGE) test

test:
	docker run $(RUN_OPTIONS) $(IMAGE) make test

test-coverage:
	rm -rf ${PWD}/coverage
	mkdir -m 777 ${PWD}/coverage
	docker run  $(RUN_OPTIONS) -v ${PWD}/coverage:/coverage -e COVERAGE_DIR=/coverage $(IMAGE) make test-coverage

.PHONY: test-image test test-coverage
