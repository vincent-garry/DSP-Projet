pipeline {
    agent any

    environment {
        DOCKER_REGISTRY = 'vincent-garry'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Images') {
            steps {
                script {
                    def appType = ''

                    // Déterminer le type d'application basé sur la branche
                    if (env.BRANCH_NAME.contains('html-css')) {
                        appType = 'html-css'
                    } else if (env.BRANCH_NAME.contains('nodejs')) {
                        appType = 'nodejs'
                    } else if (env.BRANCH_NAME.contains('java')) {
                        appType = 'java'
                    } else if (env.BRANCH_NAME.contains('php')) {
                        appType = 'php'
                    } else if (env.BRANCH_NAME.contains('python')) {
                        appType = 'python'
                    } else if (env.BRANCH_NAME.contains('ruby')) {
                        appType = 'ruby'
                    } else if (env.BRANCH_NAME.contains('swift')) {
                        appType = 'swift'
                    } else {
                        error "Unknown branch type: ${env.BRANCH_NAME}"
                    }

                    def imageName = "${DOCKER_REGISTRY}/${appType}:${env.BRANCH_NAME}"

                    echo "Building Docker image ${imageName}"
                    docker.build(imageName, "-f Dockerfile.${appType} .")
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    // Déployer les conteneurs Docker avec Docker Compose
                    sh 'docker-compose up -d'
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}
