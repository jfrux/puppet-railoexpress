require "puppet/util/execution"

Puppet::Type.type(:railoexpress).provide :railo_init do
  include Puppet::Util::Execution

  optional_commands :railo_init => "railo_init"

  def create
    command = [
      "#{@resource[:railoexpress_root]}/bin/railo_init",
      "install",
      @resource[:version]
    ]

    command << "--source" if @resource[:compile]

    if Puppet.version =~ /^3\./
      execute command, command_opts
    else
      withenv command_env do
        execute command
      end
    end
  end

  def destroy
    command = [
      "#{@resource[:railoexpress_root]}/bin/railo_init",
      "uninstall",
      @resource[:version]
    ]

    if Puppet.version =~ /^3\./
      execute command, command_opts
    else
      withenv command_env do
        execute command
      end
    end
  end

  def exists?
    File.directory? \
      "#{@resource[:railoexpress_root]}/versions/#{@resource[:version]}"
  end

  def command_opts
    {
      :combine            => true,
      :custom_environment => command_env,
      :failonfail         => true,
      :uid                => @resource[:user]
    }
  end

  def command_env
    {
      "railoexpress_root" => @resource[:railoexpress_root],
      "PATH"        => "#{@resource[:railoexpress_root]}/bin:/usr/bin:/usr/sbin:/bin:/sbin"
    }
  end
end
