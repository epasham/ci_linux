node {   
    stage('Code Checkout') {
  	checkout scm
  	sh 'git submodule update --init' 
    }

    stage('Pre-Checking') {
  	#sh 'if ! mount | grep -q ServerAutoInstall; then ansible-playbook playbook-precheck.yml fi'
  	sh 'echo "1111"'
    }

#    parallel InstallationMangoDb: {
#        stage ('MangoDb') 
#        {
#            sh 'ansible-playbook playbook-mangodb.yml'
#        }
#    }, InstallationElasticSearch: {
#        stage ('ElasticSearch') 
#        {
#            sh 'ansible-playbook playbook-elasticsearch.yml'
#        }
#    }, InstallationLicenseAgent: {
#        stage ('License Agent') 
#        {
#            sh 'ansible-playbook playbook-licenseagent.yml'
#        }
#    }, InstallationServiceMonitor: {
#        stage ('Service Monitor') 
#        {
#            sh 'ansible-playbook playbook-servicemonitor.yml'
#        }
#    }
}

