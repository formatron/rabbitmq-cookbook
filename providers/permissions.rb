def whyrun_supported?
  true
end

use_inline_resources

action :set do
  name = new_resource.name
  vhost = new_resource.vhost
  conf = new_resource.conf
  write = new_resource.write
  read = new_resource.read
  list = Mixlib::ShellOut.new "rabbitmqctl list_user_permissions #{name}"
  list.run_command
  list.error!
  match = list.stdout.match(/^#{vhost}\s+#{conf}\s+#{write}\s+#{read}$/)
  if match.nil?
    set = Mixlib::ShellOut.new "rabbitmqctl set_permissions -p #{vhost} #{name} \"#{conf}\" \"#{write}\" \"#{read}\""
    set.run_command
    set.error!
    new_resource.updated_by_last_action true
  end
end
