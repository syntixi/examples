# Tensorflow Serving Environment Example

## Create Environment 

```bash
$ syntixi env create --name tensorflow --image syntixi/tensorflow-serving-env --version 2
```

## Create Package

```bash
$ zip -r half_plus_two.zip ./half_plus_two
$ syntixi bundle create --env tensorflow --deploy half_plus_two.zip
```

## Create Function

Here, the `--entrypoint` represents the name of the top directory contains the trained model and what kind of API the model supports.
Currently, three API are supported: `predict`, `classify`, `regress`. `predict` API will be used if no API kind was given.

```bash
$ syntixi fn create --name t1 --bundle <pkg name> --env tensorflow --entrypoint "half_plus_two:predict"
$ syntixi fn test --name t1 --body '{"instances": [1.0, 2.0, 0.0]}' --method POST
```
