
node {
  stage 'Docker build'
  docker.build('cg2-linux-asg/demo')
 
  stage 'Docker push'
  docker.withRegistry('https://041444721655.dkr.ecr.us-east-1.amazonaws.com', 'ecr:us-east-1:ECR') {
    docker.image('cg2-linux-asg/demo').push('latest')
  }
}
