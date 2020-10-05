# Syntixi Node.js Examples

This is V2 example, check [here](README_V1.md) for V1.

This directory contains several examples to get you started using Node.js with Syntixi.

Before running any of these functions, make sure you have created a `nodejs` Syntixi environment:

```bash
# Create an environment with default nodejs images
$ syntixi env create --name nodeenv --image syntixi/node-env:latest --builder syntixi/node-builder:latest
# Create zip file from our example
$ zip -jr nodejs.zip nodejs/
# Create a package with the zip file
$ syntixi bundle create --sourcearchive nodejs.zip --env nodeenv
```

## Function signature

Every Node.js function has the same basic form:

```javascript
module.exports = async function(context) {
    return {
        status: 200,
        body: 'Your body here',
        headers: {
            'Foo': 'Bar'
        }
    }
}
```
## hello.js

This is a basic "Hello, World!" example. It simply returns a status of `200` and text body.

### Usage
Since it is an `async` function, you can `await` `Promise`s, as demonstrated in the `weather.js` function.

```bash
# Create a function
$ syntixi fn create --name hello --bundle [pkgname] --entrypoint "hello"

# Test the function
$ syntixi fn test --name hello
```

## index.js

This file does nothing but for demonstrating `require` feature.

### Usage
```bash
# Create a function, you can skip `--entrypoint` as node will look for `index.js` by default
$ syntixi fn create --name index --bundle [pkgname]

# Test the function
$ syntixi fn test --name index
```

## multi-entry.js

This is a multiple exports example. There are two exports: entry1 and entry2

### Usage
```bash
# Create a function for entry1
$ syntixi fn create --name entry1 --bundle [pkgname]  --entrypoint "multi-entry.entry1"

# Test the function
$ syntixi fn test --name entry1

# Create a function for entry2
$ syntixi fn create --name entry2 --bundle [pkgname]  --entrypoint "multi-entry.entry2"

# Test the function
$ syntixi fn test --name entry2
```

## hello-callback.js

This is a basic "Hello, World!" example implemented with the legacy callback implementation. If you declare your function with two arguments (`context`, `callback`), a callback taking three arguments (`status`, `body`, `headers`) is provided.

⚠️️ Callback support is only provided for backwards compatibility! We recommend that you use `async` functions instead.

### Usage

```bash
# Create a function
$ syntixi fn create --name hello-callback --bundle [pkgname] --entrypoint "hello-callback"

# Map GET /hello-callback to your new function
$ syntixi route create --method GET --url /hello-callback --function hello-callback

# Run the function.
$ curl http://$Syntixi_ROUTER/hello-callback
Hello, world!
```

## kubeEventsSlack.js

This example watches Kubernetes events and sends them to a Slack channel. To use this, create an incoming webhook for your Slack channel, and replace the `slackWebhookPath` in the example code.

### Usage

```bash
# Upload your function code to syntixi
$ syntixi fn create --name kubeEventsSlack --bundle [pkgname] --entrypoint "hello-callback"

# Watch all services in the default namespace:
$ syntixi watch create --function kubeEventsSlack --type service --ns default
```

## weather.js

In this example, the Yahoo Weather API is used to current weather at a given location.

### Usage

```bash
# Upload your function code to syntixi
$ syntixi function create --name weather --bundle [pkgname] --entrypoint "weather"

# Map GET /stock to your new function
$ syntixi route create --method POST --url /weather --function weather

# Run the function.
$ curl -H "Content-Type: application/json" -X POST -d '{"location":"Sieteiglesias, Spain"}' http://$Syntixi_ROUTER/weather

{"text":"It is 2 celsius degrees in Sieteiglesias, Spain and Mostly Clear"}
```
