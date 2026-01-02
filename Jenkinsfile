pipeline{

    agent any

     tools {
        maven 'Maven-3.9.12'   // MUST match Jenkins tool name exactly
        jdk 'jdk17'           // optional but recommended
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
                sh 'mvn clean install'
            }
        }

    }
}