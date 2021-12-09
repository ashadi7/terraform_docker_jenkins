pipeline {
    agent {label 'awsslave'}

    parameters {
        string(name: 'environment', defaultValue: 'terraform', description: 'Workspace/environment file to use for deployment')
        booleanParam(name: 'autoApprove', defaultValue: false, description: 'Automatically run apply after generating plan?')
        booleanParam(name: 'destroy', defaultValue: false, description: 'Destroy Terraform build?')

    }


     environment {
       // AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
       // AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
          AWS_ACCESS_KEY_ID=sh(returnStdout: true, script: "curl http://169.254.169.254/latest/meta-data/iam/security-credentials/delegate-admin-jenkins | jq '.AccessKeyId'").trim()
          AWS_SECRET_ACCESS_KEY=sh(returnStdout: true, script: "curl http://169.254.169.254/latest/meta-data/iam/security-credentials/delegate-admin-jenkins | jq '.SecretAccessKey'").trim()
          AWS_SESSION_TOKEN=sh(returnStdout: true, script: "curl http://169.254.169.254/latest/meta-data/iam/security-credentials/delegate-admin-jenkins | jq '.Token'").trim()
          AWS_SECURITY_TOKEN = ${AWS_SESSION_TOKEN}   
    }


    stages {
        //stage('checkout') {
        //    steps {
        //         script{
        //                dir("terraform")
        //                {
        //                    git "https://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@github.com/ashadi7/CICD.git"
        //                }
        //            }
        //        }
        //    }

        stage('Plan') {
            when {
                not {
                    equals expected: true, actual: params.destroy
                }
            }
            
            steps {
           //        sh """ 
        //               AWSCreds=curl -v http://169.254.169.254/latest/meta-data/iam/security-credentials/delegate-admin-jenkins
          //             AWS_KeyID="echo $AWSCreds | jq '.AccessKeyId'"
          //             AWS_SecID="echo $AWSCreds | jq '.SecretAccessKey'"
          //             AWS_Token="echo $AWSCreds | jq '.Token'"
          //             echo $AWS_KeyID
           //            echo $AWS_SecID
           //        """
            //    println "${AWS_KeyID}"
           //     println "${AWS_SecID}"
           //     println "${AWS_Token}"
                sh 'make  tf-init tf-plan tf-validate'
            }
        }
        stage('Approval') {
           when {
               not {
                   equals expected: true, actual: params.autoApprove
               }
               not {
                    equals expected: true, actual: params.destroy
                }
           }
           
                
            

           steps {
               script {
                    def plan = readFile 'tfplan.txt'
                    input message: "Do you want to apply the plan?",
                    parameters: [text(name: 'Plan', description: 'Please review the plan', defaultValue: plan)]
               }
           }
       }

        stage('Apply') {
            when {
                not {
                    equals expected: true, actual: params.destroy
                }
            }
            
            steps {
                sh "terraform apply -input=false tfplan"
            }
        }
        
        stage('Destroy') {
            when {
                equals expected: true, actual: params.destroy
            }
        
        steps {
           sh "terraform destroy --auto-approve"
        }
    }


  }
}
