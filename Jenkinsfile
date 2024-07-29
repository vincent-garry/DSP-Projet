pipeline {
    agent any

    environment {
        // Configure Docker as needed
        DOCKER_IMAGE = "html-css-app-dev"
        DOCKER_COMPOSE_FILE = "docker-compose.yml"
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
                    echo "Building Docker image: ${DOCKER_IMAGE}"
                    sh "sudo docker build -t ${DOCKER_IMAGE} ."
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    echo "Deploying using ${DOCKER_COMPOSE_FILE}"
                    sh "sudo docker-compose -f ${DOCKER_COMPOSE_FILE} up -d"
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
