#
# Cookbook Name:: nginx
# Resource:: site
#

actions :create, :delete, :enable, :disable

default_action :create

attribute :name, kind_of: String, name_attribute: true
attribute :listen, kind_of: String, default: "80"
attribute :host, kind_of: String, default: "localhost"
attribute :root, kind_of: String, required: true
attribute :index, kind_of: String, default: "index.html index.htm"
attribute :location, kind_of: String
attribute :cookbook, kind_of: String, default: "nginx"
attribute :source, kind_of: String, default: "site.erb"
attribute :remove_paths, kind_of: Array, default: []

attr_accessor :exists
