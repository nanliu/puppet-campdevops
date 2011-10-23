include jenkins

class {
  "jenkins" :
    require => Class["jenkins"],
}

