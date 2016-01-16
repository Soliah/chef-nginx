require "serverspec"

set :backend, :exec

describe "nginx::default" do
  describe package("nginx") do
    it { should be_installed }
  end

  describe file("/etc/nginx/mime.types") do
    it { should be_a_file }
    it { should be_owned_by "root" }
    it { should be_grouped_into "root" }
    it { should be_mode "644" }
  end

  describe file("/etc/nginx/nginx.conf") do
    it { should be_a_file }
    it { should be_owned_by "root" }
    it { should be_grouped_into "root" }
    it { should be_mode "644" }
  end

  describe file("/var/log/nginx") do
    it { should be_directory }
    it { should be_owned_by "www-data" }
    it { should be_grouped_into "adm" }
    it { should be_mode "755" }
  end

  describe file("/etc/nginx/sites-available") do
    it { should be_directory }
    it { should be_owned_by "root" }
    it { should be_grouped_into "root" }
    it { should be_mode "755" }
  end

  describe file("/etc/nginx/sites-enabled") do
    it { should be_directory }
    it { should be_owned_by "root" }
    it { should be_grouped_into "root" }
    it { should be_mode "755" }
  end

  describe file("/etc/nginx/sites-available/default") do
    it { should be_a_file }
    it { should be_owned_by "root" }
    it { should be_grouped_into "root" }
    it { should be_mode "644" }
  end

  describe service("nginx") do
    it { should be_enabled }
    it { should be_running }
  end

  describe port(80) do
    it { should be_listening }
  end
end
