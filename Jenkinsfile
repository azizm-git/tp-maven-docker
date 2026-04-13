node {
    def registryLocal   = 'localhost:5000/webapp-isoset'
    def registryDocHub  = 'azizmjd/webapp-isoset'
    def registryGitlab  = 'registry.gitlab.com/azizm-git/aziz_gitlab/webapp-isoset'
    def IMAGE = "${registryLocal}:version-${env.BUILD_ID}"
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

    stage('Push Local') {
        docker.withRegistry('http://localhost:5000') {
            img.push('latest')
            img.push()
        }
    }

    stage('Push Docker Hub') {
        withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
            sh "docker login -u $USER -p $PASS"
            sh "docker tag ${IMAGE} ${registryDocHub}"
            sh "docker push ${registryDocHub}"
        }
    }

    stage('Push GitLab') {
        withCredentials([usernamePassword(credentialsId: 'gitlab-creds', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
            sh "docker login -u $USER -p $PASS registry.gitlab.com"
            sh "docker tag ${IMAGE} ${registryGitlab}"
            sh "docker push ${registryGitlab}"
        }
    }
}