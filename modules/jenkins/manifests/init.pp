#
# A simple module to pull in and install Jenkins on CentOS/RHEL
#

class jenkins {
  $jenkins_key_path = "/etc/pki/rpm-gpg/jenkins-ci.org.key"

  file {
    "${jenkins_key_path}" :
        owner => root,
        group => root,
        mode  => 0444,
        source=> "puppet:///modules/jenkins/jenkins-ci.org.key",
  }

  yumrepo {
    "jenkins" :
      gpgkey  => "http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key",
      baseurl => "http://pkg.jenkins-ci.org/redhat/",
      name    => "Jenkins",
      require => File["${jenkins_key_path}"],
  }

  package {
    "jenkins" :
      ensure  => present,
      require => YumRepo["jenkins"],
  }

  service {
    "jenkins" :
      enable  => true,
      ensure  => running,
      require => Package["jenkins"],
  }
}
 # vim: ts=2 sw=2 et