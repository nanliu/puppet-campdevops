#
# A simple module to pull in and install Jenkins on CentOS/RHEL
#

class jenkins {
  yumrepo {
    "jenkins" :
      gpgkey  => "http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key",
      baseurl => "http://pkg.jenkins-ci.org/redhat/",
      name    => "Jenkins",
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
  }
}
 # vim: ts=2 sw=2 et
