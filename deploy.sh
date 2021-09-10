docker build -t bhmkyndryl/kuber-fibo-client-k8s:latest -t bhmkyndryl/kuber-fibo-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t bhmkyndryl/kuber-fibo-server-k8s-pgfix:latest -t bhmkyndryl/kuber-fibo-server-k8s-pgfix:$SHA -f ./server/Dockerfile ./server
docker build -t bhmkyndryl/kuber-fibo-worker-k8s:latest -t bhmkyndryl/kuber-fibo-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push bhmkyndryl/kuber-fibo-client-k8s:latest
docker push bhmkyndryl/kuber-fibo-server-k8s-pgfix:latest
docker push bhmkyndryl/kuber-fibo-worker-k8s:latest

docker push bhmkyndryl/kuber-fibo-client-k8s:$SHA
docker push bhmkyndryl/kuber-fibo-server-k8s-pgfix:$SHA
docker push bhmkyndryl/kuber-fibo-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=bhmkyndryl/kuber-fibo-server-k8s-pgfix:$SHA
kubectl set image deployments/client-deployment client=bhmkyndryl/kuber-fibo-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=bhmkyndryl/kuber-fibo-worker-k8s:$SHA