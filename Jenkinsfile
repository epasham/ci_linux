node {
  stage 'Bake Image'
  sh './build.sh || true'
  stage 'Push Image'
  docker.withRegistry('https://041444721655.dkr.ecr.us-east-1.amazonaws.com', 'ecr:us-east-1:ECR') {
    docker.image('cg2-linux-asg/redis').push('latest')
  }
}
