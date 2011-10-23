include jboss::java

class {
  "jenkins" :
    require => Class["jboss::java"],
}
