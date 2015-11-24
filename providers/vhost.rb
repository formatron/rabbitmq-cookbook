def whyrun_supported?
  true
end

use_inline_resources

action :add do
  path = new_resource.path
  list = Mixlib::ShellOut.new 'rabbitmqctl list_vhosts'
  list.run_command
  list.error!
  match = list.stdout.match(/^#{path}$/)
  if match.nil?
    add = Mixlib::ShellOut.new "rabbitmqctl add_vhost #{path}"
    add.run_command
    add.error!
    new_resource.updated_by_last_action true
  end
end
