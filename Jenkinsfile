node {
  stage 'Checkout Code'
  checkout scm
  sh 'git submodule update --init' 

  stage 'Bake Image'
  sh './build.sh || true'

  stage 'Push Image'
  docker.withRegistry('https://041444721655.dkr.ecr.us-east-1.amazonaws.com', 'ecr:us-east-1:ECR') {
    docker.image('cg2-linux-asg/redis').push('latest')
    docker.image('cg2-linux-asg/task-engine').push('latest')
    docker.image('cg2-linux-asg/mongo-db').push('latest')
    docker.image('cg2-linux-asg/rabbitmq').push('latest')
    docker.image('cg2-linux-asg/elasticsearch').push('latest')
  }
}
