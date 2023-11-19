pipeline {
  agent any


   environment {
        AWS_ACCOUNT_ID="710255125651"
        AWS_DEFAULT_REGION="us-east-1" 
	DESIRED_COUNT="1"
        IMAGE_REPO_NAME="flask-project"
	EKS_CLUSTER_NAME="flask-eks"
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
           sh 'docker build -t ${IMAGE_REPO_NAME} .'
      	  }
    	}

	stage('Push Docker Image to ECR') {
            steps {
				sh "docker tag ${IMAGE_REPO_NAME}:${IMAGE_TAG} ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}:${IMAGE_TAG}"
				sh "docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}:${IMAGE_TAG}"
            }
        }

	stage('Integrate Jenkins with EKS Cluster') {
	    steps{
		    script{
			 sh 'aws eks update-kubeconfig --name ${EKS_CLUSTER_NAME} --region ${AWS_DEFAULT_REGION}'   
		    }
	    }
	}

	stage('Deploy App in EKS Cluster') {
            steps {
		script {
		   sh 'curl -LO "https://storage.googleapis.com/kubernetes-release/release/v1.20.5/bin/linux/amd64/kubectl"'  
        	   sh 'chmod u+x ./kubectl'
        	   sh './kubectl apply -f eks-deploy-proyect.yml'
		}
        
            }
        }


  }
  post {
    always {
      sh 'docker logout'
    }
  }
}
