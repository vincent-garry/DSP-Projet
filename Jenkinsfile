pipeline {
    agent any

    environment {
        // Définir des variables d'environnement
        DOCKER_IMAGE = "${env.BRANCH_NAME}-app"
        DOCKER_COMPOSE_FILE = "docker-compose.yml"
        APP_PORT = "8002"
        APP_PORT_PHPMYADMIN = "8083"
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
                    sh "docker-compose -f ${DOCKER_COMPOSE_FILE} up -d --remove-orphans"
                    
                    // Debug: Check contents of /var/www/html
                    sh "docker-compose -f ${DOCKER_COMPOSE_FILE} exec -T web ls -la /var/www/html"
                    sh "docker-compose -f ${DOCKER_COMPOSE_FILE} exec -T web cat /var/www/html/index.php"
                    
                    // Debug: Check Apache configuration
                    sh "docker-compose -f ${DOCKER_COMPOSE_FILE} exec -T web apache2ctl -M"
                    sh "docker-compose -f ${DOCKER_COMPOSE_FILE} exec -T web cat /etc/apache2/sites-enabled/000-default.conf"
                    
                    // Debug: Try to access index.php
                    sh "curl -v http://localhost:${APP_PORT}/index.php"
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
