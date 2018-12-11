node {   
    stage('Build') {
  	checkout scm
  	sh 'git submodule update --init' 
    }

    parallel InstallationMangoDb: {
        stage ('MangoDb') 
        {
    	    sh 'echo "-----------mangodb----------"'
            sh 'sleep 60'
        }
    }, InstallationElasticSearch: {
        stage ('ElasticSearch') 
        {
    	    sh 'echo "----------ElasticSearch--------"'
            sh 'sleep 60'
        }
    }, InstallationLicenseAgent: {
        stage ('License Agent') 
        {
    	    sh 'echo "-----------License Agent----------"'
            sh 'sleep 60'
        }
    }, InstallationServiceMonitor: {
        stage ('Service Monitor') 
        {
    	    sh 'echo "--------- Service Monitor-----------"'
            sh 'sleep 60'
        }
    }
}
