node {   
    stage('Build') {
    	sh 'echo "Build stage"'
    }

    parallel firstBranch: {
        stage ('11111') 
        {
    	    sh 'echo "11111 start"'
            sh 'sleep 60'
    	    sh 'echo "11111 end"'
        }
    }, secondBranch: {
        stage ('22222') 
        {
    	    sh 'echo "22222 start"'
            sh 'sleep 60'
    	    sh 'echo "22222 end"'
        }
    }
}
