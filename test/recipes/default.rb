include_recipe 'formatron_erlang::default'
include_recipe 'formatron_rabbitmq::default'

formatron_rabbitmq_vhost '/sensu'

formatron_rabbitmq_user 'sensu' do
  password 'password'
end

formatron_rabbitmq_permissions 'sensu' do
  vhost '/sensu'
  conf '.*'
  write '.*'
  read '.*'
end
