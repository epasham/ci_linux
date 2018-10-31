node {
  sh 'rm -rf ./'
  sh 'git clone https://github.com/LIUBOPENG/ci_linux.git/ || true'
  sh 'rm ~/.docker/config.json || true'
  sh './build.sh || true'
  docker.withRegistry('https://041444721655.dkr.ecr.us-east-1.amazonaws.com', 'ecr:us-east-1:ECR') {
    docker.image('cg2-linux-asg/redis').push('latest')
  }
}
