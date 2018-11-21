VERSION=$(shell cat hello-chart/Chart.yaml | grep "appVersion:" | cut -d ":" -f2 | xargs)
CHART_VERSION=$(shell cat hello-chart/Chart.yaml | grep "version:" | cut -d ":" -f2 | xargs)

build:
	docker build -t "lasko/hello-service:$(VERSION)" .

push:
	docker push lasko/hello-service:$(VERSION)

package:
	helm package hello-chart

deploy:
	helm install hello-chart-$(CHART_VERSION).tgz
