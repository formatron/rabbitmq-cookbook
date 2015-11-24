def whyrun_supported?
  true
end

use_inline_resources

action :enable do
  name = new_resource.name
  list = Mixlib::ShellOut.new 'rabbitmq-plugins list'
  list.run_command
  list.error!
  match = list.stdout.match(/^\[\s+\]\s+#{name}\s+/)
  unless match.nil?
    enable = Mixlib::ShellOut.new "rabbitmq-plugins enable #{name}"
    enable.run_command
    enable.error!
    new_resource.updated_by_last_action true
  end
end
