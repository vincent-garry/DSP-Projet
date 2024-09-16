pipeline {
    agent any

    environment {
        // Définir des variables d'environnement
        TYPE = "php"
        DOCKER_IMAGE = "vincentgarry/${TYPE}-app"
        DOCKER_TAG = 'dev' // Changez ce tag selon la version que vous voulez
        DOCKER_CREDENTIALS_ID = 'dockerhub-credentials' // ID des credentials Docker Hub stockés dans Jenkins
        DOCKER_COMPOSE_FILE = "docker-compose.yml"
        APP_PORT = "182" // Ports alloués pour NodeJS 1090 à 1190 dev
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
                    echo "Building Docker image: ${DOCKER_IMAGE}:${DOCKER_TAG}"
                    sh "docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} ."
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    // Se connecter à Docker Hub
                    withDockerRegistry([credentialsId: "${DOCKER_CREDENTIALS_ID}", url: 'https://index.docker.io/v1/']) {
                        // Taguer l'image
                        sh "docker tag ${DOCKER_IMAGE}:${DOCKER_TAG} ${DOCKER_IMAGE}:${DOCKER_TAG}"
                        // Pousser l'image
                        sh "docker push ${DOCKER_IMAGE}:${DOCKER_TAG}"
                    }
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
                    sh '''
                        # Trouver et arrêter les conteneurs utilisant le port spécifié
                        containers=$(docker ps -q --filter "publish=${APP_PORT_PHPMYADMIN}")
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
                    
                    // Wait for services to be ready
                    sh "docker-compose -f ${DOCKER_COMPOSE_FILE} run --rm web sleep 10"
                    
                    // Check directory content
                    sh "docker-compose -f ${DOCKER_COMPOSE_FILE} exec -T web ls -l /var/www/html"
                    
                    // Check database connection
                    sh "docker-compose -f ${DOCKER_COMPOSE_FILE} exec -T web php /var/www/html/db.php"
                }
            }
        }

        stage('Run Tests') {
            steps {
                script {
                    echo "Running tests..."
                    
                    // Test if the page contains a <table> tag
                    def curlCommand = "docker-compose exec -T web curl -s http://localhost:80"
                    def output = sh(script: curlCommand, returnStdout: true).trim()
                    
                    echo "Full response:"
                    echo output
                    
                    if (output.contains("<table>")) {
                        echo "Test passed: <table> found in the response"
                    } else {
                        error "Test failed: <table> not found in the response"
                    }
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
