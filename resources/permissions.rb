actions :set
default_action :set

attribute :name, name_attribute: true, kind_of: String, required: true
attribute :vhost, kind_of: String, required: true
attribute :conf, kind_of: String, required: true
attribute :write, kind_of: String, required: true
attribute :read, kind_of: String, required: true
