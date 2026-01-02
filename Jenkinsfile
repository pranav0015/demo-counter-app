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
        stage('Quality Gate Status') {
            steps {
                script{
                        waitForQualityGate abortPipeline: false, credentialsId: 'sonar-api' // for checking code quality standards
                    }
                }
            }
         stage('Push Jar to Nexus') {
            steps {
                script{
                        def readPomVersion = readMavenPom file: 'pom.xml'
                        nexusArtifactUploader artifacts: 
                        [
                            [
                                artifactId: 'springboot', classifier: '', file: 'target/Uber.jar', type: 'jar'
                            ]
                        ], 
                        credentialsId: 'nexus-auth', 
                        groupId: 'com.example', 
                        nexusUrl: '13.126.178.19:8081', 
                        nexusVersion: 'nexus3', 
                        protocol: 'http', 
                        repository: 'maven-app-release', 
                        //version: '1.0.0' // this is manually setting jar version
                        version: "${readPomVersion.version}"  // it will automatically increment the jar version
                    }
                }
            }
        
        }       
}