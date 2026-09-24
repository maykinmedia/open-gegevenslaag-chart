# Open-Gegevenslaag Chart

Generic Helm chart for deploying Maykin Django applications on Kubernetes.

It includes:

- Main application Deployment
- Celery worker, Flower, and Beat Deployments (optional)
- ConfigMap/Secret for application settings, with optional Redis-backed cache/broker
- Optional Ingress, HorizontalPodAutoscaler, PodDisruptionBudget
- Optional `django-setup-configuration` Job for post-install/post-upgrade configuration

## Tested applications

This chart has been tested against the following Maykin applications:

- [Open VTB](https://github.com/maykinmedia/open-vtb)
- [Open Organisatie](https://github.com/maykinmedia/open-organisatie)

## Documentation

Full parameter documentation (all `values.yaml` options, defaults, and descriptions) lives in [`open-gegevenslaag/README.md`](open-gegevenslaag/README.md) and is auto-generated with [helm-docs](https://github.com/norwoodj/helm-docs).


## CI scope

- TODO

## License

- TODO

## Values Schema Validation

- TODO

## Contributing

- TODO

