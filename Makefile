.PHONY: deploy_add
deploy_add:
	@echo "Building docker image ..."
	docker build . -t shuzasa/api-service:v1.0
	@echo "Deploying in kubernetes ..."
	kubectl apply -f summation-service.yaml

.PHONY: deploy_api
deploy_api:
	@echo "Building docker image ..."
	docker push shuzasa/api-service:v1.0
	@echo "Deploying in kubernetes ..."
	kubectl apply -f api-service.yaml

.PHONY: debug_deploy
debug_deploy:
	@echo "building api in debug mode..."
	cd api \
	&& eval $(minikube docker-env) \
	&& GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -gcflags "all=-N -l" -o ./app \
	&& docker build -f Dockerfile.debug -t api-debug . \
	&& echo "Deploying in kubernetes ..." \
	&& kubectl run --rm -i debug-api-deploy --image=api-debug --image-pull-policy=Never
