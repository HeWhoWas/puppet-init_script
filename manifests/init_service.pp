define init_script::init_service($daemon_name,
                   $daemon_path,
                   $daemon_bin,
                   $daemon_env_setup=undef,
                   $deamon_required_start=undef,
                   $daemon_user=undef,
                   $external_pid=undef,
                   $kill_proc_name=undef,
                   $kill_proc_args=undef,
                   $kill_by_name=false,
                   $kill_by_pid=true,
                   $daemon_opts = undef,
                   $start_service=false,
                   $chkconfig="345 20 80",
                   $daemon_desc="${daemon_name} daemon",
                   $daemon_logfile="/dev/null",
){

    init_script::init_script { $daemon_name:
      daemon_name		=>	$daemon_name,
      daemon_path		=>	$daemon_path,
      daemon_bin		=>	$daemon_bin,
      daemon_env_setup		=>	$daemon_env_setup,
      daemon_user		=>	$daemon_user,
      daemon_logfile		=>	$daemon_logfile,
      daemon_opts		=>	$daemon_opts,
      kill_proc_name		=>	$kill_proc_name,
      kill_proc_args		=>	$kill_proc_args,
      kill_by_name		=>	$kill_by_name,
      kill_by_pid		=>	$kill_by_pid,
      chkconfig			=>	$chkconfig,
      daemon_desc		=>	$daemon_desc,
      deamon_required_start	=>	$deamon_required_start,
      external_pid		=>	$external_pid
    }

    service { $daemon_name:
      ensure	=>	running,
      enable	=>	true,
      require	=>	Init_script::Init_script[$daemon_name]
    }
}
