node /^build/ {
  class {'jenkins': }
}

node /^app/ {
}

node /^deploy/ {
}

node /^souce/ {
  class {'svn': }
}

node /^db/ {
}

