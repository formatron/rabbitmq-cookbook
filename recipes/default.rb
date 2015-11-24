apt_repository 'rabbitmq' do
  uri 'http://www.rabbitmq.com/debian/'
  distribution 'testing'
  components ['main']
  key 'http://www.rabbitmq.com/rabbitmq-signing-key-public.asc'
end

package 'rabbitmq-server'

service 'rabbitmq-server' do
  supports status: true, restart: true, reload: false
  action [ :enable, :start ]
end

formatron_rabbitmq_plugin 'rabbitmq_management'
