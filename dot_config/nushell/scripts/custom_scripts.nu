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

export def describe-s3-bucket [
    bucket_name?: string
    --summary: string = "/tmp/_s3_summary.txt"
    --profile: string = "default"
] {
    if ($bucket_name | is-empty) {
        print $"Infer summary from ($summary)."
    } else {
        print $"Fetch summary for ($bucket_name) \(save into ($summary)\)"
        aws s3 --profile $profile --summarize --recursive ls $bucket_name | save -f $summary
    }
    
    print "Parse exported summary"
    (open $summary 
            | lines | parse -r '(?P<date>\d{4}-\d{2}-\d{2}\s\d{2}:\d{2}:\d{2})\s+(?P<size>\d+)\s+(?P<path>.+)'
            # Filer empty lines
            | each {|row| $row | into record} 
                | filter {|row| ($row.date | is-empty) != true } 
            # Convert size to file size
            | into filesize size
            | into datetime date
    )
}