# Installation 

## Helm 

Install helm via `homebrew` if on mac, or look at the official releases page: https://github.com/helm/helm/releases

Follow the initialization steps found here: https://docs.helm.sh/using_helm/#initialize-helm-and-install-tiller

That will initialize helm into your kubernetes cluster. It's super important to make sure you are performing those steps
on the correct kubernetes context otherwise you risk helm being installed in the wrong cluster.

I also recommend installing a yaml linter (`brew install yamllint`) to catch yaml issues.

## Helm Charts


Docs: https://docs.helm.sh/developing_charts/#charts

Helm uses a packaging format called charts. A chart is a collection of files that describe a related set of Kubernetes resources.
A single chart might be used to deploy something simple, like a memcached pod, or something complex, like a full web app stack with
HTTP servers, databases, caches, and so on.

Charts are created as files laid out in a particular directory tree, then they can be packaged into versioned archives to be deployed.

This document explains the chart format, and provides basic guidance for building charts with Helm.


Helm Chart Structure documentation: https://docs.helm.sh/developing_charts/#the-chart-file-structure

## Example Chart structure

    $ helm create hello-chart
    Creating hello-chart

This will create a hello-chart directory. Inside this directory the three files we are the most interested in are Chart.yaml, values.yaml and NOTES.txt.

Chart.yaml describes the chart, as in it’s name, description and version.

values.yaml is stores variables for the template files templates directory. If you have more complex deployment needs, that falls outside the default templates capability, edit the files in this directory. They are normal Go templates -- a nice Go template primer can be found here: (https://gohugo.io/templates/go-templates/)

NOTES.txt is used to give information after deployment to the user that deployed the chart. For example it might explain how to use the chart, or list default settings, etc. For this post I will keep the default message in it.


    $ tree hello-chart/
    hello-chart/
    ├── Chart.yaml
    ├── templates
    │   ├── NOTES.txt
    │   ├── _helpers.tpl
    │   ├── configmap.yaml
    │   ├── deployment.yaml
    │   └── service.yaml
    └── values.yaml

# Debugging

If you want to test the template rendering, but not actually install anything, you can use

    $ helm install --debug --dry-run ./hello-chart

This will send the chart to the Tiller server, which will render the templates. But instead of installing the chart, it will return the rendered template to you so you can see the output


