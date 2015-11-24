def whyrun_supported?
  true
end

use_inline_resources

action :add do
  name = new_resource.name
  password = new_resource.password
  list = Mixlib::ShellOut.new 'rabbitmqctl list_users'
  list.run_command
  list.error!
  match = list.stdout.match(/^#{name}\s+/)
  if match.nil?
    add = Mixlib::ShellOut.new "rabbitmqctl add_user #{name} #{password}"
    add.run_command
    add.error!
    set_tags = Mixlib::ShellOut.new "rabbitmqctl set_user_tags #{name} management"
    set_tags.run_command
    set_tags.error!
    new_resource.updated_by_last_action true
  else
    http = Chef::HTTP.new "http://#{name}:#{password}@localhost:15672"
    begin
      http.get 'api/whoami'
    rescue Net::HTTPServerException
      change_password = Mixlib::ShellOut.new "rabbitmqctl change_password #{name} #{password}"
      change_password.run_command
      change_password.error!
      new_resource.updated_by_last_action true
    end
  end
end
