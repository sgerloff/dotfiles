#!/bin/nu

export def read_aws_ssm [
    parameter_name: string
] {
    aws ssm get-parameter --name $parameter_name | from json | get Parameter.Value
}

export def venv_create [
    version: string
    --venv: string = venv
    --python: string = ""
    --prompt: string = venv
] {
    pyenv local $version

    mut python_path = $python
    if ($python | is-empty) {
        $python_path = ($env.HOME | path join .pyenv/shims/python)
    }
    virtualenv --clear --reset-app-data --prompt $prompt -p $python_path $venv
}

export def-env set-tw-pat [] {
    $env.ACCESS_TOKEN = (read_aws_ssm ai-github-token | str join)
}