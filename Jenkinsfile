node {   
    stage('Build') {
  	checkout scm
  	sh 'git submodule update --init' 
    }

    parallel InstallationMangoDb: {
        stage ('MangoDb') 
        {
    	    sh 'echo "11111 start"'
            sh 'sleep 60'
    	    sh 'echo "11111 end"'
        }
    }, InstallationElasticSearch: {
        stage ('ElasticSearch') 
        {
    	    sh 'echo "22222 start"'
            sh 'sleep 60'
    	    sh 'echo "22222 end"'
        }
    }, InstallationLicenseAgent: {
        stage ('License Agent') 
        {
    	    sh 'echo "22222 start"'
            sh 'sleep 60'
    	    sh 'echo "22222 end"'
        }
    }, InstallationServiceMonitor: {
        stage ('Service Monitor') 
        {
    	    sh 'echo "22222 start"'
            sh 'sleep 60'
    	    sh 'echo "22222 end"'
        }
    }
}
