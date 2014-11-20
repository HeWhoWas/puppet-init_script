define init_script::init_script($daemon_name,
                   $daemon_path,
                   $daemon_bin,
                   $daemon_env_setup=undef,
                   $daemon_opts = undef,
                   $daemon_user = undef,
                   $deamon_required_start=undef,
                   $external_pid=undef,
                   $kill_by_name=false,
                   $kill_by_pid=true,
                   $kill_proc_name=undef,
                   $kill_proc_args=undef,
                   $daemon_logfile="/dev/null",
                   $chkconfig="345 20 80",
                   $daemon_desc="${daemon_name} daemon"){

    validate_bool($kill_by_name, $kill_by_pid)
    validate_string($daemon_name, $daemon_path, $daemon_logfile, $chkconfig, $daemon_desc)

    if $kill_by_name == $kill_by_pid {
      fail("You must specify to kill by either PID or process name. Select only one and try again.")
    } elsif $kill_by_name {
	validate_string($kill_proc_name)
    } 

    file { "/etc/init.d/${daemon_name}":
      ensure	=>	present,
      owner	=>	root,
      group	=>	root,
      mode	=>	0755,
      content	=>	template('init_script/init_script.erb')
    }
}
