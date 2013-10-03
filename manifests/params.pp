# Public: Configuration for NodeJS module

class railoexpress::params {
  case $::osfamily {
    Darwin: {
      include boxen::config

      $railoenv_user = $::boxen_user
      $railoenv_root = "${boxen::config::home}/railoenv"
    }

    default: {
      $nodenv_user = 'root'
      $nodenv_root = '/usr/local/share/railoenv'
    }
  }

  $railoenv_version = '4.0.4.001'

  # Deprecated variables

  $railo_root = $::osfamily ? {
    'Darwin' => "${boxen::config::home}/railo",
    default  => '/usr/local/share/railo'
  }
}
