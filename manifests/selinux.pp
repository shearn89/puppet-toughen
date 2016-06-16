class toughen::selinux (
  $posture = 'default'
){
  case $posture {
    'default': { }
    default: {
      fail('Security posture not recognised')
    }
  }
}
