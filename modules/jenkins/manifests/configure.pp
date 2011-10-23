class jenkins::configure inherits jenkins {
  $jenkins_path = "/var/lib/jenkins"

  file {
    "${jenkins_path}/config.xml" :
      ensure     => present,
      require    => [
                      User["jenkins"],
                      Package["jenkins"],
                    ],
      source     => "puppet:///modules/jenkins/core.config.xml";

    "${jenkins_path}/plugins/rundeck.hpi" :
      ensure     => present,
      require    => [
                      User["jenkins"],
                      Package["jenkins"],
                    ],
      source     => "puppet:///modules/jenkins/rundeck.hpi";
  }

}

 # vim: ts=2 sw=2 et
