pipeline {
    agent any

    environment {
        // Définir des variables d'environnement
        DOCKER_IMAGE = "${env.BRANCH_NAME}-app"
        DOCKER_COMPOSE_FILE = "docker-compose.yml"
        APP_PORT = "1494" // Ports alloués pour PHP 1494 à 1594 preprod
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
