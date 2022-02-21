docker build -t skarthik85/multi-client-k8s:latest -t skarthik85/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t skarthik85/multi-server-k8s-pgfix:latest -t skarthik85/multi-server-k8s-pgfix:$SHA -f ./server/Dockerfile ./server
docker build -t skarthik85/multi-worker-k8s:latest -t skarthik85/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push skarthik85/multi-client-k8s:latest
docker push skarthik85/multi-server-k8s-pgfix:latest
docker push skarthik85/multi-worker-k8s:latest

docker push skarthik85/multi-client-k8s:$SHA
docker push skarthik85/multi-server-k8s-pgfix:$SHA
docker push skarthik85/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=skarthik85/multi-server-k8s-pgfix:$SHA
kubectl set image deployments/client-deployment client=skarthik85/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=skarthik85/multi-worker-k8s:$SHA