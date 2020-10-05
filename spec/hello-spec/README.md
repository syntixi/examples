This is the root directory of a declaratively specified syntixi "application".  The app
contains source code for one function (a simple "hello world") in the hello/hello.py
file.

The `specs` directory contains YAML files that specify the Syntixi environment and
function.

You can create this app on your cluster by running `syntixi spec apply` from this
directory.  See `syntixi spec --help` for other options.

After applying the spec, you can test the function with `syntixi fn test --name hello`.
