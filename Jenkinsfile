node {   
    stage('Build') {
    	sh 'echo "Build stage"'
    }

    parallel firstBranch: {
        stage ('Starting 11111') 
        {
            sh 'sleep 60'
        }
    }, secondBranch: {
        stage ('Starting 22222') 
        {
            sh 'sleep 60'
        }
    }
}
