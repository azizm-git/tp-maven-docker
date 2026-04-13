node {
    def registryProjet = 'localhost:5000/webapp-isoset'
    def IMAGE = "${registryProjet}:version-${env.BUILD_ID}"
    def img

    stage('Clone') {
        checkout scm
    }

    stage('Build Maven') {
        sh 'mvn clean package'
    }

    stage('Build Image') {
        img = docker.build("$IMAGE", '.')
    }

    stage('Run') {
        img.withRun("--name run-${BUILD_ID} -p 9090:8080") { c ->
            sh 'sleep 5'
            sh 'curl http://192.168.170.131:9090'
        }
    }

    stage('Push') {
        docker.withRegistry('http://localhost:5000') {
            img.push('latest')
            img.push()
        }
    }
}
