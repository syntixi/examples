# Binary Environment Examples

The `binary` runtime is a go server that uses a subprocess to invoke executables or execute shell scripts.

For more info read the [environment README](../../environments/binary/README.md).

## Requirements

First, set up your syntixi deployment with the binary environment.

```bash
syntixi env create --name binary-env --image syntixi/binary-env
```

## Example Usage

### hello.sh
`hello.sh` is an very basic shell script that returns `"Hello, World!"`.

```bash
# Upload your function code to syntixi
$ syntixi bundle create --name hello-bundle --env nodejs --code hello.sh

# Register this function with Syntixi
$ syntixi function create --name hello --env binary-env --bundle hello-bundle

# Map /hello to the hello function
syntixi route create --method GET --url /hello --function hello

# Run the function
curl http://$Syntixi_ROUTER/hello
```

This should return a HTTP response with the body `Hello World!`

### echo.sh
`echo.sh` shows the the use of STDIN to read the request body, echoing the input back in the response.

```bash
# Upload your function code to syntixi
$ syntixi bundle create --name echo-pkg --env nodejs --code echo.sh

# Register this function with Syntixi
$ syntixi function create --name echo --env binary-env --bundle echo-pkg

# Map /hello to the hello function
syntixi route create --method POST --url /echo --function echo

# Run the function
curl -XPOST -d 'Echoooooo!'  http://$Syntixi_ROUTER/echo
```
This should return a HTTP response with the body `... Echoooooo!`.


### headers.sh
`headers.sh` shows the access to the environment variables that hold the HTTP headers, returning the set HTTP headers.

```bash
# Upload your function code to syntixi
$ syntixi bundle create --name headers-pkg --env nodejs --code headers.sh

# Register this function with Syntixi
$ syntixi function create --name headers --env binary-env --bundle headers-pkg

# Map /hello to the hello function
syntixi route create --url /headers --function headers

# Run the function
curl -H 'X-FOO: BAR'  http://$Syntixi_ROUTER/headers
```
This should return a HTTP response with the body `... Echoooooo!`.

### hello..go
This example shows the differences between using shell scripts and binaries. `hello.go` returns `Hello World!` + the 
environment variables it received from the server.

```bash
# Build the function targeted at the right architecture
GOOS=linux GOARCH=386 go build -o hello-go-func hello.go

# Upload your function code to syntixi
$ syntixi bundle create --name hello-go-pkg --env nodejs --code hello-go-func

# Register this function with Syntixi
$ syntixi function create --name hello-go --env binary-env --bundle hello-go-pkg

# Map /hello to the hello function
syntixi route create --url /hello-go --function hello-go

# Run the function
curl -H 'X-GO: AWESOME!'  http://$Syntixi_ROUTER/hello-go
```
