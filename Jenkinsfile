node {
    stages {
        stage('Image Baking') {
            steps {
		sh "./build.sh"
            }
        }

        stage('Registry Publishment') {
            steps {
                docker.withRegistry('https://041444721655.dkr.ecr.us-east-1.amazonaws.com', 'ecr:us-east-1:ECR') {
  		    docker.image('041444721655.dkr.ecr.us-east-1.amazonaws.com/cg2-linux-asg/redis').push('latest')
  		}
            }
        }
    }
}
         
