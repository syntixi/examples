This is an example of creating a deployment package with multiple
files including some static data in text file.

### Create an environment

```
syntixi env create --name python --image syntixi/python-env:0.4.0rc --version 2
```

### Create a zip file with all your files

```
zip -jr multifile.zip *.py *.txt
```

### Create a function

Since there are multiple files, you have to specify an _entrypoint_ to
for the function.  Its format is `<file name>.<function name>`. In our
example, that's `main.main`, to run function `main` in `main.py`.

```
syntixi bundle create --name multifile-pkg --env python --code multifile.zip
syntixi function create --name multifile --env python --bundle multifile-pkg --entrypoint main.main
```

### Test it

```
syntixi function test --name multifile
```

You should see the "Hello, world" message.


## Updating the function

### Edit a file

```
echo "I said hellooooo!" > message.txt
```

### Update the deployment package

```
zip -jr multifile.zip *.py *.txt
```

### Update the function

```
syntixi bundle update --name multifile-pkg --archive multifile.zip
syntixi function update --name multifile --bundle multifile-pkg
```

### Test it

```
syntixi function test --name multifile
```

You should now see your new, edited message.

