      #/bin/bash
      set -e
      
      pip install -r requirements.txt -t src/main/python/
      aws cloudformation package --template cfn-serverless.yml --s3-bucket devenv-170805-artifacts-artifactsbucket-n12hv9fr7vpv --output-template-file cfn-serverless.out.yml