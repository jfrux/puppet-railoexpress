# Public: Install railoexpress so railoexpress versions can be installed
#
# Usage:
#
#   include railoexpress

class railoexpress(
  $railoexpress_root    = $railoexpress::params::railoexpress_root,
  $railoexpress_user    = $railoexpress::params::railoexpress_user,
  $railoexpress_version = $railoexpress::params::railoexpress_version,

  $railo_root       = $railoexpress::params::railo_root
) inherits railoexpress::params {

  archive { 'railoexpress':
    ensure => present,
    url    => "http://www.getrailo.org/down.cfm?item=/railo/remote/download/#{$railoexpress_version}/railix/macosx/railo-express-#{$railoexpress_version}-macosx.zip&thankyou=false",
    target => $railoexpress_root,
  }
}
