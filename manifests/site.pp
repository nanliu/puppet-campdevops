node /^build/ {
  class {'jenkins': }
}

node /^app/ {
}

node /^deploy/ {
}

node /^source/ {
  class {'svn': }
}

node /^db/ {
}

