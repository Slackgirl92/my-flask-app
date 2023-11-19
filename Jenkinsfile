pipeline {
  agent any


   environment {
        AWS_ACCOUNT_ID="710255125651"
        AWS_DEFAULT_REGION="us-east-1" 
	DESIRED_COUNT="1"
        IMAGE_REPO_NAME="flask-project"
	EKS_CLUSTER_NAME="flask-project"
        IMAGE_TAG="latest"
        REPOSITORY_URI = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}"
  }

  stages {
   
	stage('Logging into AWS ECR') {
            steps {
                script {
                   sh """aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}"""
                }   
            }
        }


	 stage('Build') {
      	  steps {
           sh 'docker build -t my-flask-app:${IMAGE_TAG} .'
      	  }
    	}

	stage('Push Docker Image to ECR') {
            steps {
				sh "docker tag ${IMAGE_REPO_NAME}:${IMAGE_TAG} ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}:${IMAGE_TAG}"
				sh "docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}:${IMAGE_TAG}"
            }
        }





  }
  post {
    always {
      sh 'docker logout'
    }
  }
}
