function Invoke-DiffAsHtml {
    param (
        [parameter(Mandatory)][string]$from
        ,[parameter(Mandatory)][string]$to
        ,[string]$outName = "out"
        ,[switch]$compress
    )
    $outName = ($outName.EndsWith(".html"))? $outName : $outName + ".html"
    $fromPath = Resolve-Path -Path $from
    $toPath = Resolve-Path -Path $to
    $outPath = $pwd.Path | Join-Path -ChildPath $outName
    $childPath = "python\diff_as_html\diff.py"
    $pyCodePath = $PSScriptRoot | Join-Path -ChildPath $childPath
    $cmd = 'python -B "{0}" "{1}" "{2}" "{3}"' -f $pyCodePath, $fromPath, $toPath, $outPath
    if ($compress) {
        $cmd += " --compress"
    }
    $cmd | Invoke-Expression
}