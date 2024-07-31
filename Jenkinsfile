pipeline {
    agent any

    environment {
        // Définir des variables d'environnement
        DOCKER_IMAGE = "${env.BRANCH_NAME}-app"
        DOCKER_COMPOSE_FILE = "docker-compose.yml"
        APP_PORT = "686" // Ports alloués pour Java 686 à 786 prod
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
                    echo "Running tests..."
                    // Assure-toi d'avoir un script de test pour l'application HTML/CSS
                    // Exemple: curl pour vérifier que la page principale se charge correctement
                    // sh "docker-compose exec web sh -c 'curl -sS http://localhost:80 | grep -q \"<title>\"'"
                }
            }
        }
    }

    post {
        always {
            cleanWs()
            mail to: 'vincentgarry@etu-digitalschool.paris',
             subject: "Build ${currentBuild.fullDisplayName}",
             body: "Build ${currentBuild.fullDisplayName} finished with status: ${currentBuild.result}"
        }
        success {
        echo 'Build succeeded'
        }
        failure {
            echo 'Build failed'
        }
    }
}
