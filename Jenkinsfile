pipeline {
    agent any

    environment {
        // Configure Docker as needed
        DOCKER_IMAGE = ""
        DOCKER_COMPOSE_FILE = ""
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    if (env.BRANCH_NAME ==~ /java\/dev/) {
                        DOCKER_IMAGE = "java-app-dev"
                        DOCKER_COMPOSE_FILE = "docker-compose.dev.yml"
                    } else if (env.BRANCH_NAME ==~ /java\/preprod/) {
                        DOCKER_IMAGE = "java-app-preprod"
                        DOCKER_COMPOSE_FILE = "docker-compose.preprod.yml"
                    } else if (env.BRANCH_NAME ==~ /java\/prod/) {
                        DOCKER_IMAGE = "java-app-prod"
                        DOCKER_COMPOSE_FILE = "docker-compose.prod.yml"
                    }
                    echo "Building Docker image: ${DOCKER_IMAGE}"
                    sh "docker build -t ${DOCKER_IMAGE} ."
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    echo "Deploying using ${DOCKER_COMPOSE_FILE}"
                    sh "docker-compose -f ${DOCKER_COMPOSE_FILE} up -d"
                }
            }
        }

        stage('Run Tests') {
            steps {
                script {
                    // Add steps to run your tests if applicable
                    echo "Running tests..."
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
