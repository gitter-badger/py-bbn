.PHONY: init clean lint test
.DEFAULT_GOAL := test

init:
	pip install -r requirements.txt

lint:
	python -m flake8 ./pybbn

test: clean lint
	nosetests tests

clean:
	find . -type f -name '*.pyc' -delete
