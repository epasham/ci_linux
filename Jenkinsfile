
node {
  stage 'Docker build'
  docker.build('demo')
 
  stage 'Docker push'
  docker.withRegistry('https://041444721655.dkr.ecr.us-east-1.amazonaws.com', 'ecr:us-east-1:ECR') {
    docker.image('demo').push('latest')
  }
}
