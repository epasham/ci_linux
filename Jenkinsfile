node {   
    stage('Build') {
  	checkout scm
  	sh 'git submodule update --init' 
    }

    parallel Installation: {
        stage ('MangoDb') 
        {
    	    sh 'echo "11111 start"'
            sh 'sleep 60'
    	    sh 'echo "11111 end"'
        }
    }, Installation: {
        stage ('ElasticSearch') 
        {
    	    sh 'echo "22222 start"'
            sh 'sleep 60'
    	    sh 'echo "22222 end"'
        }
    }, Installation: {
        stage ('License Agent') 
        {
    	    sh 'echo "22222 start"'
            sh 'sleep 60'
    	    sh 'echo "22222 end"'
        }
    }, Installation: {
        stage ('Service Monitor') 
        {
    	    sh 'echo "22222 start"'
            sh 'sleep 60'
    	    sh 'echo "22222 end"'
        }
    }
}
