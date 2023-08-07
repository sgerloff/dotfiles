#!/bin/nu

export def read_aws_ssm [
    parameter_name: string
] {
    aws ssm get-parameter --name $parameter_name | from json | get Parameter.Value
}

export def venv_create [
    version: string
    --venv: string = venv
    --python: string = ~/.pyenv/shims/python
    --prompt: string = venv
] {
    pyenv local $version
    virtualenv --clear --reset-app-data --prompt $prompt -p $python $venv
}

export def-env set-tw-pat [] {
    $env.ACCESS_TOKEN = (read_aws_ssm ai-github-token | str join)
}