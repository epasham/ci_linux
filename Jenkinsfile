node {   
    stage('Build') {
    	sh 'echo "Build stage"'
    }

    parallel firstBranch: {
        stage ('Starting 11111') 
        {
            sh 'echo "11111"'
        }
    }, secondBranch: {
        stage ('Starting 22222') 
        {
            sh 'echo "22222"'
        }
    }
}
