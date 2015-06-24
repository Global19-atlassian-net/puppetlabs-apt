define apt::package_and_pin(
  $ensure = 'installed',
) {
  package { $name:
    ensure  => $ensure,
    require => Apt::Pin[$name],
  }

  case $ensure {
    'present','installed','absent','purged','held','latest': {
      apt::pin { $name:
        ensure   => absent,
        packages => $name,
      }
    }
    default: {
      apt::pin { $name:
        packages => $name,
        version  => $ensure,
        priority => '2000',
      }
    }
  }
}
