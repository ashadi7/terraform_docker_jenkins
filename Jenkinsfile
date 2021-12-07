pipeline {
    agent {label 'awsslave'}

    parameters {
        string(name: 'environment', defaultValue: 'terraform', description: 'Workspace/environment file to use for deployment')
        booleanParam(name: 'autoApprove', defaultValue: false, description: 'Automatically run apply after generating plan?')
        booleanParam(name: 'destroy', defaultValue: false, description: 'Destroy Terraform build?')

    }


     //environment {
       // AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
       // AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    //}


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
                script {
                   sh (TOKEN=`curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"` && AWSCreds=`curl -H "X-aws-ec2-metadata-token: $TOKEN" -v http://169.254.169.254/latest/meta-data/iam/security-credentials/delegate-admin-jenkins` && AWS_KeyID=`echo $AWSCreds | jq '.AccessKeyId'` && AWS_SecID=`echo $AWSCreds | jq '.SecretAccessKey'` && AWS_Token=`echo $AWSCreds | jq '.Token'`)
                  sh ( echo $AWS_SecID )
                }	
                sh 'make tf-init tf-plan tf-validate'
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
