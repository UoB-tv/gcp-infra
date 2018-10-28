# Infrastructure Monitoring

## Istio
Istio is monitored by Grafana. Use port forwarding to open a connection from local computer to grafana pod.

    kubectl port-forward -n istio-system $(kubectl get pod  -l app=grafana -n istio-system -o jsonpath='{.items[0].metadata.name}') 3000:3000

## Kubernetes

All Kubernetes and GCP VM instance metrics can be viewed at Stackdriver.

https://app.google.stackdriver.com

## Service monitoring

Prometheus

    kubectl port-forward -n istio-system $(kubectl get pod  -l app=prometheus -n istio-system -o jsonpath='{.items[0].metadata.name}') 9090:9090

## Distributed Tracing
Jaegr Dashboard can be assessed by port forwarding to the kubernetes pod:

    kubectl port-forward -n istio-system $(kubectl get pod -n istio-system -l app=jaeger -o jsonpath='{.items[0].metadata.name}') 16686:16686 &
