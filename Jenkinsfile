pipeline{

    agent any

     tools {
        maven 'maven'   // MUST match Jenkins tool name exactly
    }

    stages{
        stage("Git Checkout"){
            steps{
                git branch: 'main', url: 'https://github.com/pranav0015/demo-counter-app.git'
            }
        }
        stage("Unit Testing"){
            steps{
                sh 'mvn test'
            }
        }
        stage("Maven Integration Testing"){
            steps{
                sh 'mvn verify -DskipTests'
            }
        }
        stage("Maven Build"){
            steps{
                sh 'mvn clean install' // build jar
            }
        }
        stage('Static Code Analysis') {
            steps {
                withSonarQubeEnv('sonarqubeserver') { // sonarqubeserver - server name configured in Jenkins
                    sh 'mvn clean verify sonar:sonar'
                }
            }
        }
               
   
        
    }
}