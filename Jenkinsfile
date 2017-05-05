def image
def image_name = "jenkins"
def branch_param = "${GIT_BRANCH}"

node('master') {
  stage('Checkout') {
    checkout poll:false, scm: [
      $class: 'GitSCM', branches: [[name: branch_param ]], userRemoteConfigs: [[ url: "${GIT_URL}" ]]
    ]
  }
  stage('Build') {
    image = docker.build(image_name)
  }
  stage('Push') {
      image.tag("latest")
      image.push("latest")
  }
}
