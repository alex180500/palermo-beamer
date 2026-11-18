$out_dir = '.pdf';

# Refresh the GitHub previews after a successful PDF build.
$success_cmd = 'case %D in *.pdf) cp -- %D docs/example-%R.pdf ;; esac'
    if -d 'docs';
