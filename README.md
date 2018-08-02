# blog-backends
backend services for dev with k8s


```
kubectl create namespace blog
kubectl apply -f https://github.com/kubernetes/minikube/raw/479ca10c75f6d73a71543627fd1fbe627600f5ec/deploy/addons/storage-provisioner/storage-provisioner.yaml
kubectl apply -f https://github.com/kubernetes/minikube/raw/479ca10c75f6d73a71543627fd1fbe627600f5ec/deploy/addons/storageclass/storageclass.yaml

kubectl apply -f ~/gdrive/k8s/secrets/blog-config/blog-config-secret.yml
kubectl apply -f ~/gdrive/k8s/secrets/blog-backends/gke/blog-db-secret.yml
kubectl apply -f ~/gdrive/k8s/secrets/blog-backends/blog-kafka-secret.yml
kubectl apply -f ~/gdrive/k8s/secrets/cms/gke/cms-secret.yml

kubectl apply -f ./k8s/blog-db.yml
kubectl apply -f ./k8s/blog-zipkin.yml
kubectl apply -f concourse-sa.yml

./create-secret-for-harbor.sh
./create-secret-for-nexus.sh

# Dev
kubectl create namespace blog-dev
kubectl apply -f <(sed 's/namespace: blog/namespace: blog-dev/g' ~/gdrive/k8s/secrets/blog-config/blog-config-secret.yml)
kubectl apply -f <(sed 's/namespace: blog/namespace: blog-dev/g' ~/gdrive/k8s/secrets/blog-backends/cfcr-dev/blog-db-secret.yml)
kubectl apply -f <(sed 's/namespace: blog/namespace: blog-dev/g' ~/gdrive/k8s/secrets/blog-backends/blog-kafka-secret.yml)
kubectl apply -f <(sed 's/namespace: blog/namespace: blog-dev/g' ~/gdrive/k8s/secrets/cms/gke/cms-secret.yml)
kubectl apply -f <(sed 's/namespace: blog/namespace: blog-dev/g' ./k8s/blog-db.yml)
kubectl apply -f <(sed 's/namespace: blog/namespace: blog-dev/g' ./k8s/blog-zipkin.yml)
kubectl apply -f <(sed 's/namespace: blog/namespace: blog-dev/g' concourse-sa.yml)

./create-secret-for-harbor.sh blog-dev
./create-secret-for-nexus.sh blog-dev
```
