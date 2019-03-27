node {   
    stage('Code Checkout') {
  	checkout scm
  	sh 'git submodule update --init' 
    }

    stage('Pre-Checking') {
  	sh 'ansible-playbook playbook-precheck.yml'
    }
    
}

