# Python Examples

This directory contains a Python examples to show different the features of the Syntixi Python environment:
- `hello.py` is a simple Pythonic _hello world_ function.
- `requestdata.py` shows how you can access the HTTP request fields, such as the body, headers and query.
- `statuscode.py` is an example of how you can change the response status code.
- `multifile/` shows how to create Syntixi Python functions with multiple source files.
- `guestbook/` is a more realistic demonstration of using Python and Syntixi to create a serverless guestbook.
- `sourcepkg/` is an example of how to use the Syntixi Python Build environment to resolve (pip) dependencies 
  before deploying the function.

## Getting Started

Create a Syntixi Python environment with the default Python runtime image (this does not include the build environment):
```
syntixi environment create --name python --image syntixi/python-env
```

Use the `hello.py` to create a Syntixi Python function:
```
syntixi bundle create --name hello-py-pkg --env python --code hello.py 
syntixi function create --name hello-py --env python --bundle hello-py-pkg
```

Test the function:
```
syntixi function test --name hello-py
```
