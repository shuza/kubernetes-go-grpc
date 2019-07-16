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

.PHONY: debug_deploy_api
debug_deploy_api:
	@echo "building api in debug mode..."
	cd api \
	&& eval $(minikube docker-env) \
	&& GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -gcflags "all=-N -l" -o ./app \
	&& docker build -f Dockerfile.debug -t api-debug . \
	&& echo "Deploying in kubernetes ..." \
	&& kubectl run --rm -i debug-api-deploy --image=api-debug --image-pull-policy=Never

.PHONY: delete_debug_api
delete_debug_api:
	kubectl delete deployment debug-api-deploy

.PHONY: delete_summation
delete_summation:
	@echo "Deleting add-service ..."
	kubectl delete svc add-service
	@echo "Deleting add-deployment ..."
	kubectl delete deployment add-deployment

.PHONY: delete_api
delete_api:
	@echo "Deleting api-service ..."
	kubectl delete svc api-service
	@echo "Deleting api-deployment"
	kubectl delete deployment api-deployment

.PHONY: delete_all
delete_all: delete_debug_api delete_summation delete_api
	@echo "Cleaned up ... :)"