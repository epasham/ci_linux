node {
  sh 'rm -rf /var/lib/jenkins/workspace/CI/* || true'
  sh 'rm ~/.docker/config.json || true'
  sh 'git clone https://github.com/LIUBOPENG/ci_linux.git/ || true'
  sh './ci_linux/build.sh || true'
  docker.withRegistry('https://041444721655.dkr.ecr.us-east-1.amazonaws.com', 'ecr:us-east-1:ECR') {
    docker.image('cg2-linux-asg/redis').push('latest')
  }
}
