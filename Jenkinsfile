pipeline {
    agent any
    
    tools {
        maven 'mvn-3.9.11'
        jdk 'jdk-17'
    }

    stages {
        stage('Checkout') {
            steps {
                // Clones the repository automatically
                checkout scm
            }
        }

        stage('Build, Test & Package') {
            steps {
                echo 'Compiling, running tests, and generating WAR...'
                // 'verify' handles compilation, unit tests, and packaging
                bat 'mvn clean verify' 
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('mySonarQube') {
                    bat """
                        mvn sonar:sonar ^
                        -Dsonar.projectKey=cargo-tracker ^
                        -Dsonar.coverage.jacoco.xmlReportPaths=target/site/jacoco/jacoco.xml
                    """
                }
            }
        }
    }

    post {
        success {
            echo 'Build, tests, packaging, and Sonar analysis completed successfully!'
            // Optional: Archive the generated WAR so you can download it from Jenkins
            archiveArtifacts artifacts: 'target/*.war', fingerprint: true
        }
        failure {
            echo 'The build or tests failed. Check the console output above.'
        }
    }
}