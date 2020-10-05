# Syntixi Node.js Examples

This directory contains several examples to get you started using Node.js with Syntixi.

## Environment

Before running any of these functions, make sure you have created a `nodejs` Syntixi environment:

```
$ syntixi env create --name nodejs --image syntixi/node-env
```

Note: The default `syntixi/node-env` image is based on Alpine, which is much smaller than the main Debian Node image (65MB vs 680MB) while still being suitable for most use cases.
If you need to use the full Debian image use the `syntixi/node-env-debian` image instead.
See the [official Node docker hub repo](https://hub.docker.com/_/node/) for considerations
relating to this choice.

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

Since it is an `async` function, you can `await` `Promise`s, as demonstrated in the `weather.js` function.

## hello.js

This is a basic "Hello, World!" example. It simply returns a status of `200` and text body.

### Usage

```bash
# Upload your function code to syntixi
$ syntixi bundle create --name hello-bundle --env nodejs --code hello.js

# Register this function with Syntixi
$ syntixi function create --name hello --env nodejs --bundle hello-bundle

# Map GET /hello to your new function
$ syntixi route create --method GET --url /hello --function hello

# Run the function.
$ curl http://$Syntixi_ROUTER/hello
Hello, world!
```

## hello-callback.js

This is a basic "Hello, World!" example implemented with the legacy callback implementation. If you declare your function with two arguments (`context`, `callback`), a callback taking three arguments (`status`, `body`, `headers`) is provided.

⚠️️ Callback support is only provided for backwards compatibility! We recommend that you use `async` functions instead.

### Usage

```bash
# Upload your function code to syntixi
$ syntixi bundle create --name hello-callback-pkg --env nodejs --code hello-callback.js

# Register this function with Syntixi
$ syntixi function create --name hello --env nodejs --bundle hello-callback-pkg

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
$ syntixi bundle create --name kubeEventsSlack-pkg --env nodejs --code kubeEventsSlack.js

# Register this function with Syntixi
$ syntixi function create --name kubeEventsSlack --env nodejs --bundle kubeEventsSlack-pkg

# Watch all services in the default namespace:
$ syntixi watch create --function kubeEventsSlack --type service --ns default
```

## weather.js

In this example, the Yahoo Weather API is used to current weather at a given location.

### Usage

```bash
# Upload your function code to syntixi
$ syntixi bundle create --name weather-pkg --env nodejs --code weather.js

# Register this function with Syntixi
$ syntixi function create --name weather --env nodejs --bundle weather-pkg

# Map GET /stock to your new function
$ syntixi route create --method POST --url /weather --function weather

# Run the function.
$ curl -H "Content-Type: application/json" -X POST -d '{"location":"Sieteiglesias, Spain"}' http://$Syntixi_ROUTER/weather

{"text":"It is 2 celsius degrees in Sieteiglesias, Spain and Mostly Clear"}
```
