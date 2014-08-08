#include '::ntp'

class { '::ntp':
	servers => [ 'odgw.odyssee-systemes.fr' ],
	restrict => [ '127.0.0.1' ],
}
