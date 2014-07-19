sudo rsync -avz --progress -e "ssh -i /Users/statwonk/.ssh/miami_aws.pem" ubuntu@ec2-54-242-120-55.compute-1.amazonaws.com:/home/ubuntu/ebs/raw_data/sample.csv ~/eotr_lean
