pipeline {
    agent any

    environment {
        // Définir des variables d'environnement
        DOCKER_IMAGE = "${env.BRANCH_NAME}-app"
        DOCKER_COMPOSE_FILE = "docker-compose.yml"
        APP_PORT = "1393" // Ports alloués pour PHP 1393 à 1493 dev
        APP_DB_PORT = "3307" // Port base de données à modifier à chaque nouvelle application
        APP_PORT_PHPMYADMIN = "8081"
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
                    sh '''
                        # Trouver et arrêter les conteneurs utilisant le port spécifié
                        containers=$(docker ps -q --filter "publish=${APP_DB_PORT}")
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
                }
            }
        }

        stage('Run Tests') {
            steps {
                script {
                    echo "Running tests..."

                    // Test de réponse HTTP
                    echo "Testing HTTP response..."
                    sh "docker-compose exec web curl -s -o /dev/null -w '%{http_code}' http://localhost:80 | grep -q '200'"

                    // Test de connexion à la base de données
                    echo "Testing database connection..."
                    sh "docker-compose exec web php -r 'include \"db.php\"; \$conn = connectDatabase(); if(\$conn->connect_error) { echo \"Connection failed\"; exit(1); } else { echo \"Connection successful\"; } \$conn->close();'"

                    // Test de contenu de la page
                    echo "Testing page content..."
                    sh "docker-compose exec web curl -s http://localhost:80 | grep -q '<table>'"
                    sh "docker-compose exec web curl -s http://localhost:80 | grep -q 'John Doe'"
                    sh "docker-compose exec web curl -s http://localhost:80 | grep -q 'Jane Doe'"
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
