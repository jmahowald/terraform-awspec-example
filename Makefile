AWS_PROFILE ?= personal
AWS_REGION  ?= us-east-1

test-image:
	docker build . -t gtn-deploy-test -f Dockerfile.test

test: test-image
	./workstation -c /workspace/spec/test.sh
