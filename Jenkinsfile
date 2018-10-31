pipeline {
    agent any
    stages {
        stage('Image Baking') {
            steps {
		sh "./build.sh"
            }
        }
        stage('Registry Publishment') {
            steps {
                echo 'Testing..'
            }
        }
    }
}
