pipeline {
    agent any

    environment {
        // Définir des variables d'environnement
        DOCKER_IMAGE = "${env.BRANCH_NAME}-app"
        DOCKER_COMPOSE_FILE = "docker-compose.yml"
        APP_PORT = "81" // Ports alloués pour HTML CSS 81 à 181
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
                    sh "docker build -t ${DOCKER_IMAGE} ."
                }
            }
        }

        stage('Clean Up Old Containers') {
            steps {
                script {
                    echo "Stopping and removing old containers using port ${APP_PORT}"
                    sh '''
                        # Trouver et arrêter les conteneurs utilisant le port spécifié
                        containers=$(docker ps -q --filter "publish=${APP_PORT}")
                        if [ ! -z "$containers" ]; then
                            docker stop $containers
                            docker rm $containers
                        fi
                    '''
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
                    // Ajouter des étapes pour exécuter des tests si nécessaire
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
